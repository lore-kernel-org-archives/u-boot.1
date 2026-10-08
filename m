Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC4CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EFB940A38;
	Thu,  8 Oct 2026 10:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wvsBM00fr8tf; Thu,  8 Oct 2026 10:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D3CC240A30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455068;
	b=GB2vhAmhiVv6IFngdx9P+hyi9IOPtKuVTA2O5ybLV2cP4dnpbIoy7p4DkhVS9I0hsCgw
	 2G3H+3qxt3ie+QfpdpQZ86zHu54yz/G4kUsoTHtEa0Sz+0fVlFEXYQqzxAsMjoFN7oaaY
	 INhb69XXIwl4Ly0LWZvjLdCLavk+Y3AW45rdbBP57BPzcPAeTFPLyW6AdWLybR0L7wD+n
	 B1J56PbK+7r5jFnhnxg+QI/GSp16h1EjXYDa9FvaN2jyxTIs3AqIg/iJGWcQr88lUBJL7
	 W7A5syjzDi8YRYkJXDPvCsaRm6lZ8KibJBUhu5RVVx0PoWNFLw+KdCTAf2/6gen9vyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791455068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EgWJB9ge3wjfCJVwhuYIPokOBeGxf3QfYigVgIp40kc=;
	b=e08sfQUQbW8rm4daQOc567TTxpzLJLiudFRmkWw9W966jQlqRvVCS97HUEzkRJo8/Bjs
	 bqZSmcvHdhwu34Rbj3Krr+V48E6dVMQdtGlXbGEpTlhXEspK1/2QvQLpI36AHgcplZQp6
	 vCB6Hw2afxx/hY7FXAQHCVQ9Iahd0CCTK4hC5Y7znb/aNBdeUuWnCqX567EXaqoDIAF+8
	 KmKrHJFiuBQ6ikSeycfArwkwlNreVjSzPTFYVHsIxWmRSKbjjykJjZW4Or4SOfvqQNVK+
	 QiUYbiyV/pIRcI58FuQ3WW4EBdn435unYHEgoRqNX5PiBG+yz1gNxiqn+ix7ASiYtBA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791455068;
	bh=EgWJB9ge3wjfCJVwhuYIPokOBeGxf3QfYigVgIp40kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LaIXbkEIwXZSVhyd4HiKOqwrNC+178kGd619TyOSmccVpzHwEX0XyersFeL4UbcY6
	 g6hfoLkADgnv1x/4CFisdOJB2ZY1lpZDZAzYZ83Qr66IGxLxkHNWvT9ieT95fx0h4u
	 Up23dYgUoQkb88J/Te4g/iroJ52kQ17Ibaqvb4gvg65rXzmvPAw9q+gPGCrkUf5Rzb
	 qLDDTX9hZCzX23Yuo9G1k/YazSB11Ck7tz+jTsUdilgdyQcCl9IgqcJPKI9W9Pg4Nx
	 z0A/eynkyHAqzggD4isMHjCPEayGr3MyGZOKx7b/dyjxKjQDsRb+Qgh5DaFBGkA6pI
	 dG3mxW6MAq+ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3CC240A30;
	Thu,  8 Oct 2026 10:24:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC5FF2AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDEB38121E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:24:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-wSXNyUfS_M for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:24:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB4C98121B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455065;
 b=i+6HnWywnE4ERdoerCZZnMKfayVDmi3bD2Sh6HhY210f0iu+m5s1lfAUykFe6fDSjbv1
 awFJQUUnjoysKbRR0aSmWE0n10tLBGNMRmRO43HnfgeOW7ZgzpJF+nEsGisPO52dZ0Otf
 /A1gxdCd/UYhp+R0OiBJO2SdPbGbEBLFf+znoT4hxGxsXnY8vSzHhAbYXJUuV9Bmo+jLe
 4Wg7ba5RaCu2R4ggnAloJY5cfZuBjYFMqmZng8kyRDsuerRFMnX0GruHJmZN/Fay+YsHD
 u9YczZC65CADkTfrtP0WMfUWiITU7lW7vDqxUXi8aB0cNuco5YiuzqpdoQRv/JW87Ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791455065;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=EgWJB9ge3wjfCJVwhuYIPokOBeGxf3QfYigVgIp40kc=;
 b=TItsfFMIAilerB+GxvbgdmwqMGH+KW2D9FW2vA83RCz++ntb9PWfovksSvvEbcSFeiwZ
 pdD/12lta21B5+8S+BMkvsvkaKg/UuUILP/ohIKiZJV6VRa6B+rKqNvDIaid4Ri7p1p7F
 iiUtuJZKUSoO4F9QzUehb2ZKvl/iqsV+K81+zA9dkQCxY1tJHpJq8lqy2TSXU+PbWH0lL
 baxPpYhC9KsmpWh7R2lOtdCdFnzNzVEQdW7eGAmdIMbMrpf339HRpaX5W7/x/t5cnRBWu
 TTyd4X9OsNTcyhV6PhNepwNLo6mof5fwF9YLBivihSc1OI6xyT2ukwtBoYI5I4xDGSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gdFDo1YG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gdFDo1YG
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB4C98121B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:24:24 +0000 (UTC)
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-677af43eed4so2843248d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791455063; cv=none;
 d=google.com; s=arc-20260327;
 b=XH017oCNkY6Tfqq2VsuuMh3I3ueqT6RsdaVnNlpIQQuc3zHCSGjI1BBf7c/GkI0KsH
 4WJjgwBQBjNfHBpwu9KmnnIJHOsry8n2e15NoDE93PJDRb8yM3eYiC1uE7sWm3DG056F
 nOEQ7ZUnLxN3FL60SC2t93UfxPSOYyl49XFRf2EncRYqUJb0FqElp0NaZvM/zLxSdpf7
 mCMarRM9ccrD705yyHUkdh3GeEJ8CGpCbNEkPiFVgJmcrB4cwluRxDJUD8uxQk7VLkzd
 LGLGbKCFylBawBTN+v7avUYUxiOg7dxTYrJvDxDv1Ckf8q9/2SsGyx2GbRxfbR+mEKVx
 tBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EgWJB9ge3wjfCJVwhuYIPokOBeGxf3QfYigVgIp40kc=;
 fh=zFCM/c/DsDChw9gi3oxRx06XCt/581I3D0ccNAQ9FqA=;
 b=BnAbcIIyb1QcM2jiQ6Fpd0kknq8XZ6Nv+aCRvmXFRBpDX7YGPXNprzu4OIe19MEHik
 8sTnqyTK80hrx/WN8HI2hwOTBqZ4GLrAHFxh3QRAv91oGnBMJGaMUCly7gQu1qJjYtFM
 +aOcCxJXL0Y7oQgV6e0kaesovuAcbWdFDFl0a+6/kHEPrzIP0OOJ1OEy0pg1YcHHuEKA
 y6UlI/PslM7peKU3B5KzltjwYlZxEsUsRhVUZjSM2LSYwyudiWkxutPxMj+fXLDcOG1J
 OUj8xasanFhW/mvcCxV4RclqnpPxtMIp/wIeLIMV64ADEFXV0CuMSs+q+EDBgg0B7ukk
 avAw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791455063; x=1792059863;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EgWJB9ge3wjfCJVwhuYIPokOBeGxf3QfYigVgIp40kc=;
 b=gdFDo1YGO5s2uvAig4+JbO4qd8GEAsqlx/7bReJYehM4fns9ozstaBhsaxmXk0BbVP
 3Fqu2L0BBDlxdUwV4nPymGjgpmE58/dW3/7HrwolGSQvafyuh+eJt619/uP40jC/KGqB
 y0HNeZDDl+lh9MMiHISiPm2lmO3J/tcLmU9Dbfqxt+dMgG5crLO4vjVRCMmyfg5gGzkz
 p8I+Kl5Lui/mv0ZvEUCWIMaMMJMuKpSaJVJcRnNIXwHqw7GzoQMcjGUC796pSFBurwJM
 TiCZfJQ+Etvf9aR0DS2+Psai9hTFVpKMQ92eNGrU81+rCrEhyvjNq5Cu+t73OtKM5iOC
 P2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791455063; x=1792059863;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EgWJB9ge3wjfCJVwhuYIPokOBeGxf3QfYigVgIp40kc=;
 b=W2/gyH5Gt0CRuWTrLXp8nhp+M4XDc2IzKHZuG9Ku17q4Zzm4tKuxMOuq6NVhqoGdpr
 8nJcLZrgdTEIm0ei5QpIjqZlmjbkSM2uZ0RQWInJBntOlWlhc/w/QI5thuYarCrilYeA
 rDroL91BK+lg6ufJ9aZtvMWS4NgGePyqWilKlif+jD84eaSSfyZDWRCBy1E1bXwhKtsX
 NdKFs62XreZuRVsnXFtDF5jKGCv+Jknp2bv7lsV7hhGuvKQpqO0XB/4zu9P8kSRJOM1O
 yiVM564Stj7B9cIqaUrAyAwDNWmBFtGa7OWeF3T7fwdNpaOPcrhjAjxXTbjvpehZXn3/
 okRA==
X-Gm-Message-State: AFq9FYKd5mCVSyfm/+5Swnpsb8xzIS98c6tecNMsBAll8SFTnDwkYrZY
 bc0rw/4fwcP/CWRa9hqtCw3WopHteAB0Rk4+h6vO94COc0oIbz2C5Fh4XUdiW+SToh6/LIJix/w
 B5pnNS4NPCwvVFhGYMd7HJOkyqCKH04hF193aG20llw==
X-Gm-Gg: AYBFou3gmul9QfBss1qXZlFPq8XvWcPnIdFJdl7KD05WkQfqBQhZmB/oC97FqQgl+Hk
 siedDJvEzYsmTy1zDJC6lgLlGpl/4uHk3XjvV8I7w9nqezrTYTy4DIqjhC8LZmnZrDHOsINNQqw
 Qq5Qr9qycR2J6Lywv7TCSn8xC3QxneMawGLA5Mpo1nw5KqUtAKpLfmsUtVUPUQJ6AkI8cbKVwww
 RRdhxbi+Z1+tLosOOIvaSWFTQitrK7zuK4ZithLtU9Ct6k0pExB4vH2NOTyJGAARRx6WGzkJUSE
 q9puYQXsrpzdCNRIW5CsSi5aUwYpGxKB9Pq+zO0rgAyZFh9GvRS7V/d2T42/xLtzZ487dzDLggL
 fyMZaRUpyJ2cv2p5iA7DDkuJV2gm59QShNiDaHSs/8XUBvTTePXocDsjw4PnuoGZYrOuh2LDydB
 V7zftcf5ZqrUnhhwFug1bGk3qoRY48NAEKdqEdoaWU50OrYA178Kzft5Z2A823AEJjzT7XIXsOV
 cxJL+3dwgMAySocSezma4rpln+ylCR1zcSJVBa+GqH7NIv/lG4dIMUmZjWldgzwUV0pQlcY+1Y0
 OzLwPItmheQAiTaiE9ny06CkkE/HOWEvF4sOkF6BlwMoMpDqtvIDkJ2DarGG28hDN6xoOLQJHKh
 vQxzVOu5m/Yzz231r6GjHrCTkD8w+AJnLudQTMRd6gAeWW3ZCxatexA==
X-Received: by 2002:a53:ac82:0:b0:677:ceec:5eb4 with SMTP id
 956f58d0204a3-6790a24520dmr3326098d50.74.1791455062853; Thu, 08 Oct 2026
 03:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-3-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-3-michael.haener@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 13:23:46 +0300
X-Gm-Features: AclHuK9Stm7TXMESaPMlQHmt-eYeNVPalj4H2Vyg5FOcEDTeWLDeHZDf-WhdzxY
Message-ID: <CAC_iWjKOVGp7PmPkkQ7h7iTRNR4pgzbqoDnpsfJ_vpcHOfkOtg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] tpm: Add tests for CONFIG_TPM_AUTOSTART
To: Michael Haener <michael.haener@siemens.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

I am not too familiar with the EVT testing here, but I remember that
we had to add new events in test/py/tests/test_event_dump.py

Simon is that correct?

Thanks
/Ilias

On Tue, 6 Oct 2026 at 18:52, Michael Haener <michael.haener@siemens.com> wrote:
>
> Enable CONFIG_TPM_AUTOSTART on sandbox and add two tests which send
> EVT_LAST_STAGE_INIT: one checks that the TPM is started, the other that
> the event does not fail when there is no TPM device.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> ---
> Changes in v3:
> - New patch, split out of patch 1
>
>  configs/sandbox_defconfig |  1 +
>  test/dm/tpm.c             | 44 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index a2708e6fb33..3efbdc6fdf1 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -400,6 +400,7 @@ CONFIG_ECDSA=y
>  CONFIG_ECDSA_VERIFY=y
>  CONFIG_RSASSA_PSS=y
>  CONFIG_TPM=y
> +CONFIG_TPM_AUTOSTART=y
>  CONFIG_ERRNO_STR=y
>  CONFIG_GETOPT=y
>  CONFIG_TEST_FDTDEC=y
> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> index 87c5c416daa..46e843787f1 100644
> --- a/test/dm/tpm.c
> +++ b/test/dm/tpm.c
> @@ -5,8 +5,11 @@
>   */
>
>  #include <dm.h>
> +#include <event.h>
>  #include <tpm_api.h>
> +#include <dm/device-internal.h>
>  #include <dm/test.h>
> +#include <dm/uclass-internal.h>
>  #include <test/test.h>
>  #include <test/ut.h>
>
> @@ -197,3 +200,44 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
>         return 0;
>  }
>  DM_TEST(dm_test_tpm_autostart_reinit, UTF_SCAN_FDT);
> +
> +/* Check that CONFIG_TPM_AUTOSTART starts the TPM from the init event */
> +static int dm_test_tpm_autostart_event(struct unit_test_state *uts)
> +{
> +       struct udevice *dev;
> +       char buf[50];
> +
> +       if (!IS_ENABLED(CONFIG_TPM_AUTOSTART))
> +               return 0;
> +
> +       ut_assertok(get_tpm_version(TPM_V2, &dev));
> +
> +       ut_assert(tpm_report_state(dev, buf, sizeof(buf)));
> +       ut_asserteq_str("init_done=0", buf);
> +
> +       ut_assertok(event_notify_null(EVT_LAST_STAGE_INIT));
> +
> +       ut_assert(tpm_report_state(dev, buf, sizeof(buf)));
> +       ut_asserteq_str("init_done=1", buf);
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_tpm_autostart_event, UTF_SCAN_FDT);
> +
> +/* Check that a missing TPM does not make the init event fail */
> +static int dm_test_tpm_autostart_event_missing(struct unit_test_state *uts)
> +{
> +       struct udevice *dev;
> +
> +       if (!IS_ENABLED(CONFIG_TPM_AUTOSTART))
> +               return 0;
> +
> +       while (!uclass_find_first_device(UCLASS_TPM, &dev) && dev)
> +               ut_assertok(device_unbind(dev));
> +
> +       ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_TPM, &dev));
> +       ut_assertok(event_notify_null(EVT_LAST_STAGE_INIT));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_tpm_autostart_event_missing, UTF_SCAN_FDT);
> --
> 2.55.0
>
