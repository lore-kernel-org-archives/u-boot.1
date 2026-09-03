Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED76C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 15:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE0F860B79;
	Thu,  3 Sep 2026 15:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHe5hcBkUTVS; Thu,  3 Sep 2026 15:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CC19460B66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788449605;
	b=flxxJ9vLN1Q9xJPz5V8jr5Pxhz++PftG4K+0tCiRbXnpzc9THN3tz0FjocgEDP0YvvPg
	 V9ZWW6cqCN49pTovQLy7fNhuRGYkz6Ewc5FL6+7g5/Llywz1BaI86TP2Mrbwh4U2OoGkj
	 8sZHGM13DA6L6zQepu4ZX50hgwDT/fExelYRawUEE2Qi+oG9ilFrG84PpauxVaVoGK60f
	 VpnLFwrYps7q+mmkdAwbiT76OpFTDqNjGyNmLs1Zr4SUDMzaJ487V9pQ1mb25vJP0/GkF
	 BVu9z4I0NMT2CIk1/5DNDkce6ocmh/+GS5GQBtBxn766itgSBBtItqdysJqPJvqkJuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788449605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fKW2CEN+aUaBLGSbM4i0B+h9Ins3gSLE5fwl3ccNuLg=;
	b=BSFhlD8IK4K+YG20fGL1555eR2Zx+Vf5h1Ni+k3PgTlhVymj07bMAxUI7W2jmC+BzquC
	 ScahDco9AHuHXRA4ywa4y77EHlVI8/sYDty6iEQnMSsGZ1QVmkF7gfyxeEz635G7w2+lZ
	 2HbmByN2eRMrvW5uAa6cKSf43o3vlCVy3gzAyXC40BX1dZuSlTbTsFZSzioEDM0Z2DR0A
	 oSQKxauV1Qkd9plC/+4q7/vqgGmpmxz3O4Y7VHB5fyeShyTjvPFFvOw5nDwuuQP070mWw
	 D5QA3yjiO8CtfBI9aYOv1zA2ZFA9I1udbBP1qvwaCKgra7+LpqjBTZLpBHanKxTTPNg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788449604;
	bh=fKW2CEN+aUaBLGSbM4i0B+h9Ins3gSLE5fwl3ccNuLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ASQ6n7/zR8umqxVgnvv9rzWloTH8w+bLyfP3MDGsFd4hn4/a88QZK4hGepokVi9EV
	 NDF8X6T8nqM8wOV/jsC2AKJsW0nTRBm0qHXfJLZOqkTgoiCOSLiYKwz2Mov0b/mITc
	 63XMSfN9z2bLXV8/PA7XSPNtdjSX2aopVp0Sw9RYHjMOatXnC9Qh+hxJEKaM0DoSgw
	 9VoBlssZJT7C6e3pqu/0PlIvVMJt+mEFTvAEDzgNKEKMn+p/2KzpE75JGxWNH895Fy
	 oTLSrwUdbsyBz2O984VuKIi/vpas4NUN10rzXA7ee2UHQzOcOd0/KaPyRZ2CRUnfX2
	 wdqE8bs4QipPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC19460B66;
	Thu,  3 Sep 2026 15:33:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50EC634E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3617580F7E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ITCho4UxzYF9 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 15:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 59B3780E8A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a34"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788449600;
 b=asZoyUJEKF9Nm6J5/wHCfogPpqD5GjlK6L9N3vsUdGA8HcF1BDlLhKsUzjXvidcnW57k
 +jLCBIfbXmK50tKjH1ZkUpFELLih7ZzFW3FQ3TPMIUbtYEr21xAzyvjDUgo8BSaNABFCY
 dMyNOBRrRu66k/jxXO+3gb8EjAw2i7iu30hMw3Ao6XBLiww+bFUTECQt4/FuZpgAJG1+O
 LjSC1Mdou2CS6lhYz8dRfDlotHRCRJcHHMTmcM2ZoWTI7LgqNyiEF4Evv0rGVSJTR2cwj
 IQmhINdTVBFhqrfa1iHpQKsWJCL+SRDCnUR9xyv5sV/hDuLm6SIbeyhdiU2MnOT3IrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788449600;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=fKW2CEN+aUaBLGSbM4i0B+h9Ins3gSLE5fwl3ccNuLg=;
 b=kZbLb2kjTyjQ03NhE1qUx61ufZXKWuMTyIvkmqKHBz5nFFi3vJ3XJgKtIIyy1FvpR7j8
 +U8rVIlCuz4mkd/qQAaxpR9GQI4CSgOTYi0p4w3VY5c2Srv3gXMoPrnb6JeVYLyYppw6b
 LZw/ZJzvL1e9RX3cm2qad8kt2jcMLAxYWKNSwhOyy02EytOpEbhRCzOdXOCNKQt9Bz4Wp
 Ca06o9igH55JgKnovxo/mtzi+1OFzFT3bnY50NVvlF1ZdI+swEiDp2zxGGGYy+2EIkgca
 9ZA1vLmzosA+yW5gdqYXWu42YSeYVWyHmvPwAOPu/JQU65YsWds3PNB03ODOgl45TCA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rYrxA1ks; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rYrxA1ks
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59B3780E8A
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:33:19 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5c675de8e1dso1034112e0c.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 08:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788449598; cv=none;
 d=google.com; s=arc-20260327;
 b=Abq61WGYHfHdNCJohsBeuYXP9BqtKqu7ORUtsnDaGaNnbf9hL5YOHjmfvhkY1/2heI
 n8eg1S3LVbFKBsW+1BajzFFh7KFbGEDTjV+l4mS3OOQ3jHJ9ECt+SOWgZ/ePVyOo3dgs
 gvdSSt1BXoxKDIqY8LxpWqhBuMngrnBMswhKFbOtk04u+q8iA/HgALwvYlCa5iK/wdvY
 9WLxmCE1awhLf8ThMqsOvDWpemTUJu6iaM/nBnFvW57y36e5W3V79Cbj+3i7RhQC2c8N
 r23Mj4VqZrelqRYuFHB0YWsfbHq7Ijxe4O+PyZLA0DhWfi1u1PYTrzTwqSrhdkGUw7U7
 f9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fKW2CEN+aUaBLGSbM4i0B+h9Ins3gSLE5fwl3ccNuLg=;
 fh=5FjwxwscGPGVn8R7ZohqnBDZwsg7z1qCc2b5KI8/pAE=;
 b=Jewn7+frYaN5G4f1zUllqHQSz64bjJM7oZHMXnmRArFDHbO0ipiMQ5gPRVrtW+bnBs
 QLYwdeJ3ODgLDK9P1JCrDR00KRBm14CM0zbZLzftBmjZ81/a50+tDgoCjxm75zcXW6x8
 BEO2sDw+hBZMabMYSoq3wJZGMXyNsb6aNaxzVjm32kA0P5Lhj2qL+KK/RJnmsCHUeKei
 9EHIcSZEsrZY2LsPDmaC3lHzR+1NFGl1E1tQGaTcSCDQ6O5AoQmzF6YJzYt3V9agaIH+
 N40QBH2uDUDnvF1Vjd3vRo9rYdzB72zAK+M7poJfgcU8hSe94MlqC4aa58djHHFm1EOQ
 nI2w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788449598; x=1789054398;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fKW2CEN+aUaBLGSbM4i0B+h9Ins3gSLE5fwl3ccNuLg=;
 b=rYrxA1ksxzjzfkkkRMVDBYU///8gHVd7UoVLaGG+EMCYo3GJQXbzarH8P/xLq6nrKR
 U8iALXuEQB52dKTLM8RkuRPiZISjd9e6fA06tj9UnjxaW3YqpiynE0QKMsU5nK1rJJLs
 e2sVCIebOT1eSD+U9vqfwAYEVwp+5w8CZ3jbCvSbVvhLQmwznLe/UXc0v80/pbLzv9/f
 3pKcUpLtcA6ARK/entJ5Erfyy7ohiNkHosMsAiKfbS2hMFw1FMuiieYnEr4wEkE0hy78
 muV+aa+vwz5hyzqRPfukski6ALsb3B03YbXvvdh8zIZYjVlZBrcq2ajDS0tNeLLNo66Z
 4JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788449598; x=1789054398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fKW2CEN+aUaBLGSbM4i0B+h9Ins3gSLE5fwl3ccNuLg=;
 b=Va8vlmwxAGJY/WVCtlLRsm+oXxpwIlrTY0TYfqaxRxZqrR6cjSumRFUV9t7VG+Q20W
 CXtCPguK/HgktenolxiG3HAO/fSh54JADaVxYlFyFTjdz8NQryy58IxjLLggGNTaNKSi
 DjWwFkibWTCUYwfIzuFx79LMH7qik95k4PtqfDyMAmKIQkqXs78sg7KYpk8Eu4U8Tgpm
 6dpi8e5sCTYo3kivW5FgZXAfPfz7OP+p/7EV+3QkjdN6yNOm7EJKTuKuX6Dw7fbwM9Tx
 a4RfTNkDkWKAsR52v5vnjaTDxxGyrghZZdct/mkvFWi9BXlpbjLLo++J91b4T95GscdJ
 tskA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxf3nlUtWI3APYThvI/ztqRjA0Zgcp71ZyQ9oc4QADPXdHNsqW2zyiGNcOzFACuUucQF3lU0Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n7hIbgrnO5M/PzGh+Q4MC9fbKSk7Ccit+eAK2XXz/QIRKPHBpg
 gQIMj9qC4lEx/rI3GT7Ae1HysJfBQJczmAIrLaTSbwYivjLI1t/ckMX5FhEYbE0rMpjoreFev95
 PdLbW9fCkRq5sBffNfTXU0VjDUIZFMGA=
X-Gm-Gg: AYBFou11BLhp7oIZpX3/tCcGE4WqmDkE4R1uXfZWPIKawC9Dlv7SJdpXVJOVDNcacNh
 7xrb2VemPOfaRmrKFhE5ixKBmTxjDlU4uaO13IV0OuGkt1ny2jx3prb/WngBZ+cFluSuvzfbOR7
 otUhfEOy0ODOa+4La0633g3B2uBmWF6OxnMvnvBbGGSLyG7Tc2HGfBauz653KRlC+QZ3hABqQ5W
 3XFaLqxrwBtd0VBHv66X+xoJ+GT6QVh//LQv/XXK9HipvMJRGitgH4zT51zzNas0pIGNVUC7UJO
 kWWxc7PGPScJZ2H8qM3xS4uxxpanJmvjw2sF4SukFWG6XJQ=
X-Received: by 2002:a05:6122:d28:b0:5bd:81fc:ebe9 with SMTP id
 71dfb90a1353d-5c7d23ac451mr5606311e0c.0.1788449593808; Thu, 03 Sep 2026
 08:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-6-philippe.reynes@softathome.com>
 <CAMDkj5yhVhSZtV4z+=Vy1qdTO9zh5p66UyM0QsGNnFA7xOkxPw@mail.gmail.com>
In-Reply-To: <CAMDkj5yhVhSZtV4z+=Vy1qdTO9zh5p66UyM0QsGNnFA7xOkxPw@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 11:33:01 -0400
X-Gm-Features: AcwNN1VJQNKPNJ8fKXVzdq19ALS0QmN_kO6z6AImaDh2TJ-oEUrXt6-YPz2Z36I
Message-ID: <CAMDkj5yMzQJLPsGrbLHDcpoYK1no2etBNTN3htetmNc9E0wdnA@mail.gmail.com>
Subject: Re: [PATCH v9 05/15] drivers: crypto: add software ecdsa support
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe

On Thu, Sep 3, 2026 at 10:32=E2=80=AFAM Raymond Mao <raymondmaoca@gmail.com=
> wrote:
>
> Hi Philippe,
>
> On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
> <philippe.reynes@softathome.com> wrote:
> >
> > Add a software ecdsa driver so it is
> > now possible to use ecdsa signature on
> > board without ecdsa hardware support.
> >
> > Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> > ---
> > v2:
> > - no change
> > v3:
> > - add depends on ECDSA_VERIFY to ECDSA_SW
> > - change sw_ecdsa_verify to ecdsa_hash_verify
> > - v4
> > - use ECDSA_MBEDTLS to build the driver
> > - clean include (change order)
> > v5:
> > - use $(PHASE_) in the Makefile for the driver
> > v6:
> > - remove include u-boot/ecdsa.h from ecdsa-sw.c
> > v7:
> > - no change
> > v8:
> > - no change
> > v9:
> > - no change
> >
> >  drivers/crypto/Makefile         |  1 +
> >  drivers/crypto/ecdsa/Makefile   |  6 ++++++
> >  drivers/crypto/ecdsa/ecdsa-sw.c | 32 ++++++++++++++++++++++++++++++++
> >  3 files changed, 39 insertions(+)
> >  create mode 100644 drivers/crypto/ecdsa/Makefile
> >  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
> >
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
>

Sorry, there is a new line at the end of the file. Please apply my tag
with this fixed.

Applying: drivers: crypto: add software ecdsa support
.git/rebase-apply/patch:89: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Thanks!
Regards,
Raymond


> Thanks!
> Regards,
> Raymond
>
> > diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> > index e4a4482b7f3..8170e4cae9c 100644
> > --- a/drivers/crypto/Makefile
> > +++ b/drivers/crypto/Makefile
> > @@ -4,6 +4,7 @@
> >  #      http://www.samsung.com
> >
> >  obj-$(CONFIG_EXYNOS_ACE_SHA)   +=3D ace_sha.o
> > +obj-$(CONFIG_ECDSA) +=3D ecdsa/
> >  obj-y +=3D aes/
> >  obj-y +=3D rsa_mod_exp/
> >  obj-y +=3D fsl/
> > diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makef=
ile
> > new file mode 100644
> > index 00000000000..89be50824cb
> > --- /dev/null
> > +++ b/drivers/crypto/ecdsa/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> > +#
> > +
> > +obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) +=3D ecdsa-sw.o
> > diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecd=
sa-sw.c
> > new file mode 100644
> > index 00000000000..2af1405f73b
> > --- /dev/null
> > +++ b/drivers/crypto/ecdsa/ecdsa-sw.c
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> > + */
> > +#include <crypto/ecdsa-uclass.h>
> > +#include <crypto/internal/ecdsa.h>
> > +#include <dm.h>
> > +#include <linux/types.h>
> > +
> > +static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
> > +                              const struct ecdsa_public_key *pubkey,
> > +                              const void *hash, size_t hash_len,
> > +                              const void *signature, size_t sig_len)
> > +{
> > +       return ecdsa_hash_verify(pubkey, hash, hash_len, signature, sig=
_len);
> > +}
> > +
> > +static const struct ecdsa_ops sw_ecdsa_ops =3D {
> > +       .verify =3D ops_sw_ecdsa_verify,
> > +};
> > +
> > +U_BOOT_DRIVER(sw_ecdsa) =3D {
> > +       .name   =3D "sw_ecdsa",
> > +       .id     =3D UCLASS_ECDSA,
> > +       .ops    =3D &sw_ecdsa_ops,
> > +       .flags  =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRVINFO(sw_ecdsa) =3D {
> > +       .name =3D "sw_ecdsa",
> > +};
> > +
> > --
> > 2.43.0
> >
