Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BD606A33B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NFZmQOpl;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WzNgbz0C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 818C56078A;
	Tue, 20 Oct 2026 17:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W8wOsWvVfu_v; Tue, 20 Oct 2026 17:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC355607B8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792516365;
	b=RwLrPtIJtQmPj/n0/zHFuxHFa2hMXVPzVPMBCaI+M/rMkKFFDzHsc0ZJ5S5sjG8kpLYZ
	 PbDi9gdr2Tx2CppWrhV5Bm/SdfcBy27EC840LrRagAAk95BtqVk/IOwraa9J14gG7j6rb
	 eWWYP3pf+JEHfChCBC7UNkd/5BCs89JlGPavcNLI2IA7nuAaqAQ7b4KTKO5xYG+CsxlWJ
	 5gJ8NW1iKN1ugSw/ND91ft0MRZkt4+46glr1pohrXf1Lm0VVaKluEKkEked071ymeWsP3
	 TzmyVk29sOZ0jO9WIfVWyo+xgcQzg74sDGpSNP7IVCB7L3sTe3eGZ0bJasr+EYcPamA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792516365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AAbeFL0X2ShYnSfb8TlgF2GRWe/2/ZIPtytWL5we3us=;
	b=avNdlmisLuCsUiOLECR0NMzz4frikKSAbR+G95hUuA8SmIILl7Ssdvxs6Vh0eBe8XUiL
	 PPbFM+eAfqa6jvLnqPIk6CZqXUf53TZan7iiwfZlYwvMjY8esxLBbZvFmRhwBzGyuyGEt
	 rhxS/X88WCsOOFYuvSspbyP0PPK7Ovs21pHe68cjqSWbKwTIWFlzA4WynkNQPac6IoPpk
	 yHr2hVhLWpFHUnhED0ECP8uKnX8Wlv6rcMfvaYNwKVgwFalVvVKlKoEArQFbbRXAsOGB6
	 QELf3KrVP7439VuC0wT8u5PjjqYnbCGXvNMRUGIVEk9nRKM4JzVBr5lJ6zOGZWMpNdw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	spf=fail smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WzNgbz0C;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792516365;
	bh=AAbeFL0X2ShYnSfb8TlgF2GRWe/2/ZIPtytWL5we3us=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NFZmQOplUufCmV1EX8FlX5H/7G/YhaIDJz3IGAQttBHmeENB2doT3Ap/EDTJGWGv7
	 4wZvaNEoKIduWkeMIp3/JC4nSMK8b1bYRXEEMNLogCvHpiavejHhUriLmhlEpjOQgf
	 X/4kJ9Ru6UaFXnCA14yrfOC/P2xK8gN+wl2zIXkBEako2tRslDYaGbNe9RMjuYu+kt
	 502G67qY6r6/Wuukl4IXhrI/1DzDz9BKmVn0zm2wwxWimYB3f+Z3gY+Vd+JpakO45t
	 +oD0nXiolvPSyKYi93w4Lfn4UtG428NWDo1Q+OMhKr68lCYqci+/1nUdnUeF/zSLQj
	 78Zrh7CGxMgPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC355607B8;
	Tue, 20 Oct 2026 17:12:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2D63930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9905E607B8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CFXCalTKHq7q for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FD376078A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792516362;
 b=OmIDmDoWl+kMvg31E3/FL1xuyh71CI5zzAGDk7VkgdqojCfTgBHN+j3nKsafYwWjjIek
 SVm6+/BVsr63/h/HlI5AYflgTpqlj0o5yCHL/bwOoQZ70Bp/eHP5TtxzasB8k987W6mpF
 RIrYO633SihXDrHpSE1LcLLAezD9DKM/KGBmYBDa8Wi3U/jr3A1DR93K/WeX/Cd67Maza
 OHDdK6cp3/EFp2zF8/xE01HKpBas/ynKZPHC6UemrY1syBAbHd76dSTyo396Fv9eZkxVv
 Ct5r8F00jGqAJLw+eLwrHRHImMI0v7fjlyMb7pBjcyGNfqVcs1Ha1yjhUGnvYRuuliA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792516362;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=AAbeFL0X2ShYnSfb8TlgF2GRWe/2/ZIPtytWL5we3us=;
 b=edkdmp9jbHcLLuyl3qta4M4gjl9Mtyf4ejWNnk6zRh2jyG/zc1PyUe8SX+PrjAM0YVTO
 RmtjxsoXy0AjZRfhjAoQ9gu1qorHDHHEUxi8MPS+6BwyA8V88xKZbr+YRnGoYDHAySROU
 xudyQqFaXnusVin0JVnozB7ifXyBDN8LopRLcppl4gRUi3vEn+u67s7SGD0XwDJYOST/D
 JseBA4A3HFwHtr4biDxHsBDJR2IAAIumpQ7gWZ1QDbNRmQWmY05GGAGc0Hym2BW/5RwDk
 0BbMNFPTG2qJD6uC1+bCF6mL4L6SwdkgRVkdczYQFWEB0UAcX7zOy7f6gTkkCK1yvGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WzNgbz0C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WzNgbz0C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FD376078A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:12:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F79483E76; Tue, 20 Oct 2026 19:12:39 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE328056B
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 19:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso443231766b.3
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 10:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792516351; cv=none;
 d=google.com; s=arc-20260327;
 b=FaYzq8US01JukaRwEe7lUuqrLPK/enLwt0OtvtC18ZZIhblcUYelffFdXQSaY74ZmG
 v+LErpiBhQgqHSx08MGsvWlZjvPI9BZUWgZFzldlq4HueKPUe2NrYjD4Tm0EZmjE3sAK
 tiuYdToh8miglHGDkSWW01Ryt8BPEOIcxHuIMho42nVTxePJ75gFn751sxpg1vCt9KG5
 kTBP5DfybhBJEj2nE9ylJFe07VRiEqrodSqDZyfEg38gpEyG+XoKzH02QOgcbtNb6I4H
 VNyaThll5d980xnyivuZ4WkRsrewp31eXyP01gK1L6HQKNkvUml/KKSyPLxNjS9PAYQ/
 0wKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AAbeFL0X2ShYnSfb8TlgF2GRWe/2/ZIPtytWL5we3us=;
 fh=xDAvisX+2kmr1htkDwCNYV5lg92HqHZec/LoKVg8ucE=;
 b=KgbJtNz5STMpQM8KXnHTG78ofZC6nUWZ2iN821Sh2XR9rBRzXbyD79yMWFp+OZvAuK
 3esROwmkN574tePUvCAdP09ITwp4tXypI3WNsIU93UxrcfnK/jUTOWofBNu5gsUkpuzb
 wyechjl48N+bY5p5fiUHMSvtfx6Yf/TSmFri7P1QDfskm6SZBTXynbM6UdFU1xF10D3k
 DIUcY0ur22/5zLnGfXBhvxph14GiZiCdBVUpEUIWm/E45eNHOA9kJtjOiIsKA8eTdO+S
 SEK8KGUmWyuBWGsKJuFoFVt/GMUUd1vxhJUsmt93A94oglGwNnWr3mOdRnaREqtQyVSk
 IR1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792516351; x=1793121151; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AAbeFL0X2ShYnSfb8TlgF2GRWe/2/ZIPtytWL5we3us=;
 b=WzNgbz0C2T8L+YEP03uu50AsE3+KDWkLGwoH8iYzUycrt5t0HztQKYO19t/0tAdWdP
 umK2UrGXuFg3nStcpdMSk8qpwFrID2lrngdCtCDuT26cdvRVJZ3ICujKYHds+zMK3SgM
 MnzOKG+7iBCPTQhri4mEc+NtEJp7vx5iNAGyzXAEsSqyC3a1IjajsowWRKgN/JJMg23I
 Pb5Nq5VrS260NPoPZV3L5nHO3UM9yxAvofxJFqpB+cq4g3328v5X9NN2TVEaShOHuyO3
 H9a3+BApueOcBVwm2mkakppNI3T2Kpo6RrNezYK86tEDmLyrjvfjIdDekPHKsPRsAztu
 S7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792516351; x=1793121151;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AAbeFL0X2ShYnSfb8TlgF2GRWe/2/ZIPtytWL5we3us=;
 b=DiK9uHhEKQeUg87+Q4nLNO5gwPyYgGasnslNOidfy6lWwbJsW66e2RDcHtaedznbo4
 GetTeZ6TcG1WUHrG5aLx2x+xrR0nsUVpbanCB+L5nKpIyZ+4kReeP8ljm4zBLDDwhqyY
 zQS89zomopKkG2cfKu6bCwbLBjKyMUPPcmcqrz8EXJ+GT3SST908QM7e4QD0cdI2bcZM
 FYTuT6o3qSTt7sSeHfRKn844cy5uoVpnxWJGduEvEzmTckyZD16B/bQ+MwYOlkEF1je+
 qGkp/n66dX9pUxSkeimq6Om1rxoywuZOua8tDtL72PgpeewDlLoyj0PjENbeh/tG9Muf
 y26w==
X-Gm-Message-State: AFq9FYILgO82HLddh7gn7RVM39PGVkT4dxl9n6sgUdr1ZkDV0s8kW6Nx
 dftuRuUvOE5DZpFZAVuWz6zKkDnevaQ3FCJqI5cr2Y7J8RpHmfu9zc8T1vBigc3dIT9SCPziD/I
 ELvvKv69CfSVwB604EgHh5xi0tnMimPs=
X-Gm-Gg: AYBFou1YjmUvViekk4ivmoZD6yndHMBAy0XDgGt1MPp7xcOQivXNLElAfbrNY9zSKlN
 XkeaGMVT8vsuT93d1ibBZU6ZIpHAnpgLyMJywQNxfkt5Ya/2Lu2zo7tPx+abR0Pw+xV9NhjqZJp
 QM+DbZpbm6APIbkSXIR4fjKfPR2If3ltniCx6YUuT+tKGouGXNKTQM3YNhEWufUNUTRjzFWDkP7
 +KRQRGy5adDDQctN0+9t5KkV4PuzKAkAEfG+axivYgRo/JdcWG07Q5IQDt7RUSW4MV2k9edlPea
 PgJ3XVgg0j9YXKXsmgHFoWmWlGuw7Fd03wkKSRF/6xLcOCgam2gd+PUi
X-Received: by 2002:a17:907:3f1f:b0:c2e:4e08:19ab with SMTP id
 a640c23a62f3a-c419df3e373mr865179866b.16.1792516350529; Tue, 20 Oct 2026
 10:12:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020091125.4015-1-nimeshacharya197@gmail.com>
In-Reply-To: <20261020091125.4015-1-nimeshacharya197@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 20 Oct 2026 19:12:17 +0200
X-Gm-Features: AclHuK-6GbrXasbJ2jr7D4Lb7EILPRxsqA0n9qvCFAiyP-c1heOialZdC9cb8qg
Message-ID: <CAC928HbqsAmo0QXE8HPtbs7q5q0AyUgKCmR2zmkvdb8r8+CYqA@mail.gmail.com>
Subject: Re: [PATCH v2] configs: socfpga_de10_standard: Fix raw partition
 booting from SDMMC
To: Nimesh Acharya <nimeshacharya197@gmail.com>
Cc: u-boot@lists.denx.de, hsnaves@gmail.com, marek.vasut+socfpga@mailbox.org, 
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@altera.com, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nimesh,

Il giorno mar 20 ott 2026 alle ore 15:21 Nimesh Acharya
<nimeshacharya197@gmail.com> ha scritto:
>
> When using the default meta-intel-fpga configuration in Yocto
> 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
> U-Boot from the raw a2 partition on the SDMMC device.
>
> This change configures SPL to locate the raw U-Boot image using the
> partition type and data offset, rather than relying on the
> default offset relative to the beginning of the SD card.
>
> Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
> ---
> Changes in v2:
>  - Remove CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2 since its already the default.
>
>  configs/socfpga_de10_standard_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
> index 04f9d6c8494..f01667420a0 100644
> --- a/configs/socfpga_de10_standard_defconfig
> +++ b/configs/socfpga_de10_standard_defconfig
> @@ -70,3 +70,7 @@ CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_GADGET_DOWNLOAD=y
>  # CONFIG_SPL_WDT is not set
>  CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +
> +# SPL Fails to load UBOOT without these!
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x200
> --
> 2.56.0
>

You do not have to edit bye hand the configs/socfpga_de10_standard_defconfig.

Instead, run a "make socfpga_de10_standard_defconfig menuconfig", select the MMC
raw mode that you need (by partition type instead of by sector), run a "make
savedefconfig", and move the defconfig file generated in the output directory
to configs/socfpga_de10_standard_defconfig. Then, you will have the patch
proposal to submit. Something like:

--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -27,6 +27,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CLOCKS=y
 CONFIG_SPL_PAD_TO=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_MAXARGS=32

Note that there is no CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET option
value specified in the defconfig. This value is not used at all when "by
partition type" mode is selected. Indeed, as you can see in the Kconfig, this
config option depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR which is
alternative to CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE one.

Regards,
Massimo
