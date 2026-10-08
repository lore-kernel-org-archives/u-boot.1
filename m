Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4492CCA6004
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 01:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D708607F0;
	Thu,  8 Oct 2026 01:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7uJaWz6LKGY0; Thu,  8 Oct 2026 01:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5330060670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791423444;
	b=iDiuhmkZ8mc0IOI2XKxb0eElDQvIj6UDE5OudJlPaz8tpcbWCOiO+f5N3O2igYP4w947
	 PJE2VRkL885qgWhNGJ4Car+NGB3GdLt9EFP+Qqjtp5Jc/5SfCSzOvzOFzmSGVyimCwRk0
	 jWVfH0Aky45ZP9iHC3isPn67qFsuZQawyL/d5nonL4g5GCj/lpE9IvkV/I8QrmT77i4Qd
	 b3kmXhjbtHYIDpdUbUZZv2Z2wkVf05TfpVdcFF5WHVYpezc+G8UxpSx2WR4nRhTt26yy/
	 b006CheI+07IZrlENgX9TXachIckLUZtKiA90nNzud8TUoeIonQJnYjQPY4cPUwa4Pg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791423444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LQMIFMK3r+7oOSGeYI7mwQLEUPzdIBAkwXKrCcmyQGs=;
	b=gNlCY6JXhVkQ9p238FejkKJPlu9l6ifBY9+rjo0G2DpBmTGcybCqa7i7kO5/sIJb+57f
	 NJH8k9GbgV1uWNeOwaHyEgbky+4DWIDuGbXJQlpxFsrHeIEZchGWpknHcu12bad+hkNNN
	 3KovS4BEbKB5s9YAu+ubBOatInNerXTWvYWVQOzgePm4AYhAcnqPHwTzWkDjFTTX42B7V
	 rSVs/nn8C+Abym3DGyXyvomvq5h6RAX6D9in7Ga0Rg5CL44vZCUEz6so2VVcCsOgCVP9y
	 aSITN8INWPFWyVaBO7sHZFVqAZVtS6WT16iRKCtOBM787JG1OtxRYdTH/Xv4oF7+eVA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791423444;
	bh=LQMIFMK3r+7oOSGeYI7mwQLEUPzdIBAkwXKrCcmyQGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BBxreJcJohRZXDz7DtfR+qeGEZ3c7J55ipxW36U/ya9r9ik/e6QGexm+QiC3v0g5x
	 zCscU7cnuDshwyoqk/3xBjYw9W3GxP7wYRrG6SoIyvl/ThAOfifpwGcOSCZkbVlN51
	 jIm9OA0ryoS0Zg2ttV70jXTRB/jBQVFs0q7lPgzaej2HoFybwrhoque8qOChRW/Mjr
	 YX0WFQLcKL4ypQ52zQjQZHS6NhKi+11WTuvAJpOYTFzzBhiKeymc1DSg9rtn1San9R
	 Tdex2Jk9ncZ3KCOPk9mCpPFdMjDZ+rmvjUf8nanRjk22Mtv4jIxCazMiSRg7varPu3
	 pRYSVM/csl6bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5330060670;
	Thu,  8 Oct 2026 01:37:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A96521D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 01:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6CF240062
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 01:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNRteVmg8TCi for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 01:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F1B8A40061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791421814;
 b=ZvpAwVULsbqGAQFvjz2oqvrhWe2Uq+X/WbUyafwP6VFDUuD17GeeHLIJE6iVxz9v0i3U
 RyufiZyxZ05UpsgUTKnijQA0HQ8nwj8kNYfH59bd5RaQO7W3sdbKQeozas9GiJEJDIRBl
 S04E8Tv0waAnj3eBNtknJIC9vQhKKknFQZeyMX3gObe8y2HBcDFjernu0tSw8Fy+Eenrr
 a11CCFZDbb2zPqd2Y3Tcv3RDJgDucU4q6/PyxghnhDgXwyLBrqqsjVaQGP/OlKVpDSnb/
 VUUNmLtyBDaS/xU2i9eq0B31aKc5fmke59Qu3KuWMNuc2iy9S+PF7RSK/90u4foFfxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791421814;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=LQMIFMK3r+7oOSGeYI7mwQLEUPzdIBAkwXKrCcmyQGs=;
 b=DZp7sCEjhxI9lfFVZgALJBzY88rkssRosVagXB+cIgfw9aWHKVdG/52Wxl8DENyf3i6T
 nbWB7WbU6FqnoWKG7f/2SiVclTNy78NkCG6Z/HsrW8q44xCLM2QdisJJ5OR6lSt0j6c2X
 kSd6TeCzRZlfgMP3r/x+KFXggp9J7nNqbDLd64uRFFPJ0zkG75xLPmCcr59TmxF5pahJe
 oHMnWG0TJW6MqNfU78Y5eX+1RN2e8mdwxURc/A9Usv8xj2R1caPdyaRPzcbnzpnCdaqIV
 UDqD0smfhX4VwB81oNnPZiN0YyAQgTpM4EqQm0yEy8xr4VU2Dfo8wQdJF6jR8Sr7eCg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rEKxy3Gt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rEKxy3Gt
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1B8A40061
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 01:10:11 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ae8541a2f0so26044747b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 18:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791421810; cv=none;
 d=google.com; s=arc-20260327;
 b=ZLh/+rZg/nQXgmyH1NXPqeT6Jmbubg443RZVC9hRnGwehuhQt6TfS40cnLZAlB2Ae7
 eP6xkO32vkYd+vkCF7BAHA/WB5ABeLYSb+PX0nabtAo8ziKEA5bR+XbPJ19dR22qCm2S
 WhJUk/MMa8umE11S8/zMS83fIjyTV3enBft40RMQo3yXPYwLBGYp7YQ7nt86iRKInZrI
 sSKb23Mr3/Q5amPjZjlTMz8aQ6ase4cdjpOIxBW9gLVfuWFQROx/DyBdGlN74pC/mXj3
 BJQeklWbXNZh/rt6UpJ2+3GMxmwCjmt3b4yCOgBVtPblv8kxMYeOacgmNLUp2+RB61/L
 /QTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LQMIFMK3r+7oOSGeYI7mwQLEUPzdIBAkwXKrCcmyQGs=;
 fh=Xaao9vcDLkGTEyGllVOKuWrOWyiM5iPBgopRnBheZNI=;
 b=DWO9EHnzcMzZ1psVAqQsyVMmOeKP9s5gSRfoSr2B5VoQWnUeQLpm2u+B9e0UjPRszO
 ABIBxfjih+forljYr6j8xQFmD6Ay/VY85/86mVI4TsZA6lr8ClxlubwlKgDK0195ccHI
 5HenYb3I+btPBbU7WGrlZDo9GDJlqaOe+oLRa5pM4Zp8Fk+vfryJM5raWzoc0FL49Zqv
 tEv9ZH2B5XLco7A34dOOqivlw35ZJBtEDhJlffusCL4XXfGanD79LsGX7hMmxKCGNztD
 rQpsbJYef2lUUl8kPyciqkeLq6v3B47Y7iU6l02fmgXhlDLcAW31A6OQbOx7P3NPoRWa
 mlaQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791421810; x=1792026610;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LQMIFMK3r+7oOSGeYI7mwQLEUPzdIBAkwXKrCcmyQGs=;
 b=rEKxy3GtXRxV6Vq7dbd4vuUx/92ln2PdAB1fVnCRHoDKusby2pM3hkvLUB6+nzo5QP
 MGKqGnDBu1eyy4CWp51onXQ44Kq5kaHTc8cgMmeUOTwpgCAM88GeB0X/xixHgNKPKxaO
 sy2qkYHw08AZKZNrCzuoWch89UraP3b/4prephAKw0YFnXasoB/SXMUw4IB+kDvjHG6k
 iloy10KRLSLGaJimp0Xc3k45MZrzhVgWI0iYigBiBexqx3LrPQjulafhWM3xQiP+4zNm
 D33xGas7ktry7Sauvz5mb9qtDWrFpcuJq+586DEBtSZCtyNxSzEOALcOBWeKFhvTbuEa
 bnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791421810; x=1792026610;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LQMIFMK3r+7oOSGeYI7mwQLEUPzdIBAkwXKrCcmyQGs=;
 b=TewGLhW6zcqoFh7tVQukP+JufXZo20LRgWZcoAwV95pf3IiiGc7s44zeweTUKBmiTD
 /gGOYONki6hYzbFt9cjPiP9yMSOtKr1hkSVMT0Ktjii8GxnbdVngpEsG1UT+7zeSg145
 XrBoSmhziKnSmcPFSep3QrKN3mLdPlSV+7OL77r/mKIKmNwKo6Qtcl2vZlvCCrv0NvlT
 7YdSlosB8/ym040B7OOm0GyBUOztMiBHBjSpYxajieLND8RU+1/6hKR0kh4cExUhWy9R
 WVfTqyUp7nNsKhaZ1ryRqp8+AuHHAevCvKAQ6DJrK7Af4I5wX5pS+IpJxuohbfbUspXj
 GldQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxldRwBdIZBRWHyq3ph495tUHDVB4CpxunnZ514yTv23A3aDsc+2NhOdvi4OUXQWut9FIczoSw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIX5G9HtwsoM+w6/uYjFkv7+nUs3oF2g9Fx3Z+WU/i5EQ+SHr2O
 enMYDHv/bj3ivf782kbOfu6Om4AS7R0cfKA+fPOWt5NLW8DmowoJElPy2TE75FbrEc4htMB0F6a
 rYHHUpB0UTmPJrk4dYBVHOFaalwabZfo=
X-Gm-Gg: AYBFou1mH0CC6JUAfitLYvVAKjqW3jyoRliryml+WYCwMjzuHaBLv6PeVII2sER6DXt
 KkYmVrTaf8vRC3fL9RKqhEBTUlsPcFKi+UH+WAezAKPnRMz11GWIPFCF5ksa22d7itQxYTgMwUj
 asklpavV8uabh15jDr70dWb8cwUCrt/dMcStVDw/iQf0f2hKLOPiqoZvZXKWP4EBfBnzAiT5w/2
 Up/Nvzg/DEob4ok7xyQYRmoMQSMlgMkZsE310VQwUXtKmHO680wxRrXhdTzuQptiyTaXvhJFu0W
 cVpqtzUhUzGdNaryEPY6AdLVAdIO9J3XCCwyCQ+y/jdnFdkZHju/dOifNXImRvM0CzfLYF1swLP
 4d25Ns0BahTEcdH0=
X-Received: by 2002:a05:690c:698a:b0:8ab:41ed:c08a with SMTP id
 00721157ae682-8b05abee3f9mr27531147b3.0.1791421809998; Wed, 07 Oct 2026
 18:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261007204234.1081107-1-visitorckw@gmail.com>
In-Reply-To: <20261007204234.1081107-1-visitorckw@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Oct 2026 09:09:58 +0800
X-Gm-Features: AclHuK8BRZIohCQ69m2YgpL8r_G4PFWPkvHxQADeZu80ROM2LKi4LTSNbJEORXk
Message-ID: <CAEUhbmX2xULwpJK1NaLuGBFsz6S8uVN8mx5-nrqX41QKqiz+Rw@mail.gmail.com>
Subject: Re: [PATCH] Azure: Switch u-boot-test-hooks to git.u-boot-project.org
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, sjg@chromium.org, 
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 08 Oct 2026 01:37:22 +0000
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

On Thu, Oct 8, 2026 at 4:42=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
>
> Azure pipelines still clones u-boot-test-hooks from the github mirror,
> which is missing the recent qemu arm64 9P device setup and causes the
> 9P test to fail to find a 9P device. Switch it to
> git.u-boot-project.org like gitlab CI.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  .azure-pipelines.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>
