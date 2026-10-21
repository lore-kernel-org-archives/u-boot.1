Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E42606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n2a3+EM7;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=WlSnpTXT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A38F8810C5;
	Wed, 21 Oct 2026 04:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_rP99hzKypr; Wed, 21 Oct 2026 04:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFBCD81086
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792556263;
	b=fC91NUCm/hU24bin+X/lEmQHxHjE34IYlLzdKbSUcnn3jTuzVaU1bzagz4k++iqqbB+Q
	 UDnlXuBf/gFpG6x9ianaLJ4b4zyNiAT05aoBK408Kpjb9r/qSqb0vf9D1O9wPOj5ZQXQC
	 VY1FEQnqcxDXPexiytsJSvkQ0d80f9rH68/cq87CeELwQeeXl6lbY+vnyH22O4M8SPHi+
	 WuLDDHWbYSYj5zrfRxr3TeNCMXZ7jWi+nBufP+8Drn/+Hu2jzvVfLFVcRGBdBe6Aky45p
	 QyioI0L6CaAKTyMRWLmsDukvYuJwY+gBzHPIfYJjCjoCDIOIWI7UEfygmJUY+tUJ2+A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792556263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j73Y3vxeRPUGt6y/BT6frtCxtJ/pI/7C6VfDtuHU1qY=;
	b=slExF65iMyiaRfMyDU+M0Ol0d4Bfr6vUflPVko0mqbCbOTC7bwCAu9WtwP+lZy/G/X1j
	 dGLzFKA1On8UVq+xYuozDhGJ12iGQaU6452xznJg8XGFAt30i1W0PsezdkwyDMK4mc+cP
	 T43F81wcdmdoNktt7yO8JhSmQfFBuOlprAofv+YIdudorxkpG2/gFjONZKlcerrITKyUN
	 Vz/ytX0r2rYkNtaSlIEY7/coi8GvXasJcbZ2cwTNyCkw4gxZR8ptXHN7Qge2wImPfatYi
	 03PLmY4kbjTnvjyPyBvKbefzSD1JzoCsmzBt/Z9BiDaGEbAotpXe5vnxziWGaupjxYg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792556263;
	bh=j73Y3vxeRPUGt6y/BT6frtCxtJ/pI/7C6VfDtuHU1qY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2a3+EM7v/YM5jftuMchL97O9TSKupB1y3xOehqD2XshDf8nTh2wpbUz+P7AkSpZD
	 /PjzOwP+ytXL4YOGyNMKSjXwQ/Zrmwr+K0OVxxXbiqfTRT9GX4vn+h26uAhiVswBIk
	 kTI88QAr4YWo/U6yEnci0VLHno8Lej2rl093RCv+Eu0ppo4j5dQjOAcXfmvtUDf+RL
	 j/eV6y5gP3WZhNHrenV1bi+X+eKPAIgNk+XdGfPPISmmKUviqODKyaajJT04WyWGsw
	 P1wTEiMqiV4auB+z6UJiWDsGnch8OWoZojTj+ruYTsVa1t3B/9buVehc/ZkZw7DNxW
	 zgd1Y4yaciXDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFBCD81086;
	Wed, 21 Oct 2026 04:17:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 144172A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05F9B40112
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCz1IKJl4hsh for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 04:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D4FE240060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792556261;
 b=StP1WgKgv/aumRBPvtH+UtYQ4JrGQtN8SH5JsU0gtXEebU1NViuUh3QF9vJ+QFK4sQIA
 B/eMJFkGiykC6qyPXsh9r/xeckcYYDpvsekmhc00ciw15PEIpwAYSZkoNtRQLrT2+cI+V
 9Wd55IF44toK4ymJpL8u9upZuuOy2ZqiSNSK3YDJEdgLu5BPIkQRNCIa10wiMa4yHDu2L
 SckUGrgw+rL9cLXqpm9uJJlQBAkr/YUMHeh1d+qxJi2LMc/uPI3ZQkKdw6GnNbwuME0Uu
 WOOYQqavyQ6+U6zaVu6P896D6nRHZr1f3xK/Wf28o+Zz12qwDz8jZp4C+qTLoBbJHVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792556261;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=j73Y3vxeRPUGt6y/BT6frtCxtJ/pI/7C6VfDtuHU1qY=;
 b=MtuAu+ry3wxvu1p4q9QyccdY/qi5TjVpnWrT83cwmd+mYua7ltrVttiBN8mRHsxKTPJ5
 V0GUdv5DZND9VEtdltYP9SJKRvNXqUCzKbCGkDXzHsiPeghX5V85FSoqK92/hxz3Sdl7E
 yjuQ1cWnck7jykd12YQVgN0DAvZSHm8ERXrAUGeRKHXGysrdKeglUyIX8+ApFzyA2kQg0
 NMB06vGTzb69/Xc7NAO5fv1p3cG4CjuSY7nVHLlpLkchgQ0MNHFqhNbZppA26UiIEYOo5
 3nyUumb8Aq17LA5UYHbTiRHY471qHdFHjsngZrzAdOuAVrCSG1zkSYK9OsAd4H4/Oww==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=WlSnpTXT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=WlSnpTXT
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4FE240060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:17:40 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c413dea9ca6so30590066b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792556258; cv=none;
 d=google.com; s=arc-20260327;
 b=YV9O3Uc+HP7AnOUa0sk2IiLQnVXFWdMZVt7r2Gn+En+RnTkxp6Efb246lv57LLQsGP
 FbGm/np/2Q+Or6TSs3Uqke5rhu9ibbyGyHEF4ky0Nf2IHLBflibQTz46oEL3o5KfrShr
 mX6wX8LikiREeGCn6OEpbwSF1kkRhxAa/oYsDuStIM9s9ap4EEwwf8rCeKhy2lwBvfl7
 jA80pko5b/TNjsDJRHk3YgtfhDFOxB9RQSxc+WSPlgf4PyH6wDLtpD6I5QaaLRRwTazq
 UZVAdcN6YxPAY5yrVsfxkKAA4IEzdpzpWIK/cfWjD49zlID6RXuOx9OwwDe2+a2Dvj13
 +Ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j73Y3vxeRPUGt6y/BT6frtCxtJ/pI/7C6VfDtuHU1qY=;
 fh=b1HhqqtG3fvJp2PXOgPblI9YMnwvJDd5vnbI1iU+qR4=;
 b=tCRoZlCh0FA9+XMsrbkZHNQ3Kj6l6RfDwxn0aNRAm4xnpJRAm07jsPRknRnmmyI508
 yCbUJKTKPHnXxZ5PPErv35dJtZk0MmRLrm5K9VdIJsBb783XawgG8F5f/Gpa/OPGKHSx
 5qzZhn5KL8Zfv5rvFZi2MU+VB4OUxlfM5JmR4yMrmEC9fCcW/sfdRZ5uKKd0E0JwouZJ
 jkj+m3meLYn7QwwV4Ihct4PPoXnpV2b1QnFkIov39YmPIx8I6txdC4V7c+poAk4g2zH+
 ASqCl+6NnMYwxlnhy4uIJTmNI51JGIH+uEVMKv95fnBvz5wXpWNfoFE2NDSvbnNiTPf0
 A6Dw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792556258; x=1793161058;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j73Y3vxeRPUGt6y/BT6frtCxtJ/pI/7C6VfDtuHU1qY=;
 b=WlSnpTXToQ1d8NayGC3/207XkgOsxfeQMriz9l4IYBpxKGlEy2KUwFMz7XJePvx5QV
 OSp9nsZLDaK1odNWn+kI2hnQfTvvd/M0iPH77xiscNo8GGv/RliuCLGXGD8DSvVLyTnS
 RON6+dqhSGMH/I7O8f6m5dJCIxOqOt5P4iYdQDS9no5zE4U0Tiz55AWNSkCj/uM4RWU5
 errVH76UciZES7reQmnQ5NzEU2cYxk96cZsgwGOfWiekYlCFxCKa8zEmGoF2/gSAFwrH
 02o46yXxRZMzuFyosn+OMU0INwvDrO59BRFAeKwWWpDt+vVBk4oHqOU5ISDIryrVD1qv
 +rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792556258; x=1793161058;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j73Y3vxeRPUGt6y/BT6frtCxtJ/pI/7C6VfDtuHU1qY=;
 b=Q4z4/nyA8dE6jhxEtBnN5i7T5L4ZsDW9FOm+PtkNkhmRQ6FrZzBwH/Vi0HAvQGH/zJ
 jkwZqDadLKhSmXMlYrF8YYmQ1dtLXwzlCQEpOteQ8rASM73DL9FjIau8aY8cYkWjpRPk
 +stYCuPeGgWzam7v+2M/0u8qtu9jcHywZmjyDcTW1LLBw6D2U8Y0a7V/DoKI33w6MxCl
 u1JRfBAPSVAS5UmGXw2uTdleQcHmxfSzCy9hj5mqzgzf/1U7shLDeF3183ERgibRx+JI
 BedKECGsk2bGIvsnhrT67L4xQhiq4aUU1nosaCRy6GeCMu8fbsFUeN2hOQDrkZt6LG94
 /n0w==
X-Gm-Message-State: AFq9FYJed+WYGi9ZdZL7OkPSkcKIOGGIi8Ite57WkDBqxt9CQemPqqIX
 lLTcLSZ7z5XWP5aNAbMI1nrmhKVpWAg2lNh20hTRYflL3onrE1LpWrttB8XtI0I30wiwVPWri7m
 T3iNgzRBw/hZZ5e670MOCM+ip5OTmNl1BsUBjn3UDigmiJsITCjD7Nk+YAw==
X-Gm-Gg: AYBFou04bcNRjp/giyXDF49KLtEPKM7NNBQvd4lIFBgkxQP+AT/VQ8upTnoKxAI9Rkb
 cuMspaSBFX3IMk9N6rxX6xgaccTKcYnY1sD4ZwFiMip3U36wVfDHKU7zHqGmogSAn1dxC2OWR+T
 oPweSiYIN6LaSm16wzRa+RoaXYaUBBYuoXY2mIFjuI2c46FAako9iJYwXA9JcU0HcdHIMj6nFII
 BNOfbDtgXnWCFZnc/Ztr4IeAMpqVY9lFs6N0feVOdGWk8rLbLvH3yePAoKEAzO8Uk6pkN8z/Ipw
 oxPZQ91OE/H5AkscbG7jHUm2dfnr4wMKfT6jMEX6qX2XlKBZ3maaHSiN7AjHWxgUNacBhuiytd5
 uoEHTLzwiRH1IZ8QD40KwNDuB81/qPHkMHzu7lEqawZlWGGAIrHX4u7pyWPJPeV1HX7Dn
X-Received: by 2002:a17:907:7247:b0:c40:4f39:22e8 with SMTP id
 a640c23a62f3a-c4679a1e5fbmr74944466b.44.1792556258032; Tue, 20 Oct 2026
 21:17:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
 <7a91e605-33b0-4f4f-9789-d10be821d0cc@kwiboo.se>
 <CAKTNdwG22u_51cBLbu3wufBdB9ojSQqGMPMG58x-Nk7u_xC6sg@mail.gmail.com>
 <a451ef1e-abb6-453c-b146-90d64f24f5ab@kwiboo.se>
In-Reply-To: <a451ef1e-abb6-453c-b146-90d64f24f5ab@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 08:17:27 +0400
X-Gm-Features: AclHuK8cKviqMuX9Ou7C2710JyfdfocvfqvnfahrWfYEgyk-3kGzbw_gT4rk1yo
Message-ID: <CAKTNdwHMW4HyfhSWkT241URB4H6JMg1MCt1-VOcUsufgm=So=g@mail.gmail.com>
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 10:41=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> Hi Alexey,
>
> On 10/20/2026 8:01 PM, Alexey Charkov wrote:
> > Hi Jonas,
> >
> > On Tue, Oct 20, 2026 at 9:47=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se>=
 wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 10/20/2026 6:41 PM, Alexey Charkov wrote:
> >>> No in-tree board picks a compression for U-Boot proper, so CI never
> >>> builds the compressed path of the Rockchip FIT, nor links zstd into a=
n
> >>> arm64 SPL.
> >>>
> >>> Turn it on for the generic RK3576 image, at the highest level, which
> >>> shrinks the payload from 690KB to 296KB. The image is meant to boot f=
rom
> >>> whatever medium the board has, so this suits it, and its SPL heap and
> >>> SYS_LOAD_ADDR already leave the decompressor room to work.
> >>>
> >>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>> ---
> >>>  configs/generic-rk3576_defconfig | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk357=
6_defconfig
> >>> index 5e25653820c2..dec4364876b6 100644
> >>> --- a/configs/generic-rk3576_defconfig
> >>> +++ b/configs/generic-rk3576_defconfig
> >>> @@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=3D0x2AD40000
> >>>  CONFIG_DEBUG_UART_CLOCK=3D24000000
> >>>  CONFIG_DEBUG_UART=3Dy
> >>>  # CONFIG_BOOTMETH_VBE is not set
> >>> +CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=3Dy
> >>> +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=3D19
> >>
> >> I do not like this, it breaks consistency with the other RK generic
> >> targets, which are meant to be as lean and bare minimum as possible, n=
ot
> >> a playground for testing features, we have sandbox for that ;-)
> >>
> >> Please enable this feature on a real target, not a target meant for
> >> basic board bring up and recovery.
> >
> > It is in fact quite helpful for recovery workflows, because it
> > massively reduces the size of the maskrom 0x472 payload, which as you
> > are well aware is quite a thorn in the backside, given the boot ROM
> > peculiarities. My reasoning is that the generic board build will be
> > much more likely used over maskrom than flashed to storage, unlike all
> > the other targets, so enabling compression here is pretty much a
> > no-regret move. As long as it works, of course, but that's what we
> > have tests for (and CI).
>
> The generic targets are likely used written to storage much more than
> recovery or loaded from maskrom, they are typically used by Openwrt and
> Armbian for new board targets until proper board support has landed in
> upstream Linux and U-Boot.
>
> I can understand the idea and may possible have been on-board if all RK
> generic targets were changed and tested. The inconsistency among the
> targets are my biggest concern, secondary that this adds more code that
> potentially can fail during runtime.

I could enable this on other generic targets, too, but my sample only
includes an embarrassing number of different RK3576 boards and not
other SoC versions, so testing it directly is a challenge for me.

On the potential failures - true, but see my point above regarding
tests, which I believe still stands :)

I'm not particularly attached to enabling the option on the generic
board specifically; I just thought it could help people since it helps
my use cases.

> I added these generic targets to have safe and proven defaults, because
> the evb targets that typically could be used for similar purposes
> started to grew in features, and I really do not want the same thing
> happen to these targets. Boot speed for the generic targets is also
> not a priority.
>
> > FWIW, I'm also using Zstd decompression in SPL on the Flipper One with
> > Falcon payloads, but it's not upstream yet.
>
> Maybe you can add one of the rk3576-evb boards as a target in mean time
> and test on such target?

I ran this code on a RK3576 EVB1, too. Maybe it's time to upstream its
defconfig after all. Along with my local patch patch moving the
SYS_LOAD_ADDR to a less overlapping location across existing RK3576
boards.

Best regards,
Alexey
