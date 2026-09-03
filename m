Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58105C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F5E6810F0;
	Thu,  3 Sep 2026 14:32:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XkDuQsXE99v; Thu,  3 Sep 2026 14:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 225EE810EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445921;
	b=D5+q0rncM7YNZT+CYElRuSpN8Uv6sQnyebjPZw94eFq72zivaVX5JXFE7WPzUR9+cWlu
	 s1TU5i9kWfb/xlReukiLuc1218+IWlfHeU5t+z4uKFkcejjEBN/5r+Z+sOnSmSinsp6Nf
	 zTEKxAgISUgtLX1iq4pJwcNaQHIWYdEksZ7Wr9RNwZk9O4nsy6RJCXtudOdWjj81jarEy
	 2m/wbBgO4erFCwkT19j1o9GckKZNPhsujaCeymSGxmWpGVXAbxvIc5kIJ+oMC1cECUhpr
	 AbgOHShek/uusozUYb4NaSgOSk8PlTiFNsSD5zsBafiT4pLAW9EwxVCRdmThCRAhe8w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788445921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t+lrV4Qf7tZbr2ruEvjzEpnSFUZp3V2c6gSDm9tADHk=;
	b=E3zIJPmCP0ivyWyJjj+vUnqfkMbXSNpNvDDB1viVhaFbJr+/xdnDGTEioh89vnVjRIPw
	 uhdymhSQYZqiYAMVqqCDSmt6G39a96nomrFwFgvDGsPzpT4pAmULsLRh53N1cxBTLrUog
	 4G0r9Z3HGRq+EPrN4n2sLhfk68VQsTOYgSPs7cla26hiTZRYne2rKjotyDlUMCYnJzGTJ
	 M0Tch1kiNQaY4Qb5J9R/5i+amv2arSqyWfTE6JXyawnRPm4ecCjDmwAyH8KZ3gNOfGvzO
	 qCbmG/LhRyoRh5KgxbSf2zmG/zmRSXiP49/yghlnsrQHu96X+5vBXQU+5SaBBEE1Yqw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788445921;
	bh=t+lrV4Qf7tZbr2ruEvjzEpnSFUZp3V2c6gSDm9tADHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p48yzYk7Z98qXjMuhIl/b0/kNREC8f4TECbkhgqI5dQC25t3xjkADWv/w/MdfEps7
	 hg/1QPFK7FQJB5YrBcRDzANnDPt/h6OsBw9wpQuwa1wDCintae3WPaFfpbO2ZTCyDS
	 b+HCNWK8DFpOW49+Ars+/gHEIRaFrQ7Q1jxTX/RRQwoTPOMLGT2KIKLB3Zv4KY2pef
	 cveeIh5bri7s3I9Nj3lI3x5nJ6CmxigwWmruNBwb83THiUC3IO/DKHskRjNC5f+KA9
	 qzh2TW2N5NeHESb42l+OVQtrokesRl9ZYoOi3BPCmRV33fOumThUXzfGTuh1fD6P81
	 gejN0++aBSvrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 225EE810EF;
	Thu,  3 Sep 2026 14:32:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBE4D2FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDE6840ADF
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLLV1hxVGNCQ for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 76EEE40ADD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a36"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445917;
 b=MBC9MCpMUegaKM+skNj3Y3VA9N+v6V0XhjSpBsONlyyp7pr9xxlug1kDp5NHZ4gifgHY
 axVMIQqB1pr1FI6il03nUQ7NuGBhqxhzWyGamW9aHHDGz7IYP4pvHDx5BMT1gduiOk7UY
 PXtCO9wo95uKxp/EA808W677UIr6oLMPyuRa4W/UyTkONzuq8ZmKldUHj09+g9SUXPKUi
 eFd4rMDKAu6OwaKPI9yXFbliI7eXD2WSbzGL1I5z+Oib4aTJkYJdvTziNejrO/NnjQVMK
 bQzQILVsnbfsKlhVI61+TaFHOTckdWilJZ2DBxvEtC43j1gaWTGvLd4ssM6+PHG2PXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788445917;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=t+lrV4Qf7tZbr2ruEvjzEpnSFUZp3V2c6gSDm9tADHk=;
 b=BKk0H5dpsq8/vz0ariw9O7zKg6q2L2b9OlbNjbBA3dL8TFATolLSOK0Q6cdkvGxFGo6O
 EPEkTR3EgI+/M0jVw7Z8EOe8gWzGnb464/PEH8yh5r8TiLi/6YrPdJbGOI42vYiyviVT+
 ti/Z6cS4LitqsfGEPGOaZzrS3BEqUlpV1t0tkye9gBkakwkW/woP5bAHuDpCfl+zAy9Ur
 NFYxy9iD9Vth1Xk5jzh7do9DMGBtLE3xK5jS7o9tbMYdWoqPKsXXsvBAOWjXlFm/Ol2+2
 neaBiUkU+8/FaFvIZjiZ0Cx4AitbCcyNiRgokIMOHcF1n44LIVNMdde6uDR2nk9Nf4g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BY4i82eJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a36; helo=mail-vk1-xa36.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BY4i82eJ
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76EEE40ADD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:31:56 +0000 (UTC)
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5c7d65c83feso1778257e0c.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788445915; cv=none;
 d=google.com; s=arc-20260327;
 b=O2m8aksjZo8X74W1CQNBjjCKCfUB3ji+1tLo8Q1yiZDQzF1v3t15HQBjqIlPxf6eKD
 8dcQrknk08KKRVcH1ZRM0Q8ygD5QUZKyh737E5rVpIBptfDU2yylrJHOtVWomJD3+PSw
 VB8Q+813QgGmy6daicb4SsefHk0B7iBl2xDB5S+FasJ2XOIq+ta3oWV8kLzt6NH36HZb
 6bYapR+HnHETXI1yLc2qg/ObVsqFzvs23IX0fII0aT39iaBgdXv5xHOR3wS8q4vLIKk1
 BUrofLiNZtn/LpQ3bvqFRAd9BE+uQ0iYFsz8t6UtD6XtNcL6Pm4yGFWNktNec+s9otJj
 Lm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t+lrV4Qf7tZbr2ruEvjzEpnSFUZp3V2c6gSDm9tADHk=;
 fh=2bW6bYBQwS2hF2hXwjz9d/djRDpMHhaWZrMWITyL5tw=;
 b=ThGJ8dRKQd6hBGJpnE3d8wK4NKIoQqxHYCrxnirQc/bnaazdQyVc+Oqedu4dAgyqdi
 211wKBvo2nXXtlByAhD4m15/V4J//eWNsXVHJomLGn9USv8YiWwEaSmdlz5ux2yFJ5uE
 S3aa4Q8fou81QDmDDdDCQxF/XrcCx3YH0uD8Rf8cE5SOJlTJQa8fpnUkyHuU1CXD4Xuw
 M/IDApoZLFldIHmu18jXDFzzbHBvfNWUfXaxfVkPA2D4HNviNDmZ/87xMu8h4vr+a/7z
 7QG7M6erQOiOXMBlaO74/RENp8JScf26JzbcTGj8wZxbV72kwabPV6GvviDCPUkMTtR6
 hojA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788445915; x=1789050715;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t+lrV4Qf7tZbr2ruEvjzEpnSFUZp3V2c6gSDm9tADHk=;
 b=BY4i82eJoFYX/jwp4x0jWoKib60FuJylW5qInrhSfWurJ2vs1GUhu3Vok7MECTwaRS
 E3ld+gYPIPjLC52GdXWYmb0s6Aiirr8s+jqK6SR7pZEPLM+je1EShiu6WJ9E6YuBha/0
 ru1PNbjoI5avWhZMQyR/unc80OoRyMcGJ8Zio+NCd0GxLvoTo2pZdlIT/8yimoeZl1sL
 hahalzPDrmr5K7H1iJYJ9O6If88MgQG6NfGcfprw21ZjkSIok3Dprl/ZVeCsZzWXi0Hg
 BoB/K5sP/tWFinfLjLkXvE/C+a/sDNNOz8hXx72utyXAAz7gfApa0SJRFAxB5GvZUI/j
 3MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445915; x=1789050715;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t+lrV4Qf7tZbr2ruEvjzEpnSFUZp3V2c6gSDm9tADHk=;
 b=FQzESfNUR08SPbt5UO9Mda8ktT3Qpy6sY8YrML47zg8SV20uStY21zPDeEPC0wz4Oc
 XcUxC2VG07eonGvFHBNnyoDuqinVYYGgiDAhyodGGIe74HbOUul6DQBOefMHTeczgP38
 MquXio76swqj0mwzshzvs49gqTrTZk2r9hPpBiprBzSeupnt+RK+H0HQtNb0qMfRrsjJ
 1flpAwbxqMAlBOXh/aYBgypgJctgSbZA5CYcmTnsIzZceYq6R9AdVdK4PfaHcbrfZPX0
 FxS2pNgH8P6R9wqsrNqsqOLZiXNJEEi6sD0bomK8vOd/HVQbV0mPIeF7cu+0KZpZgNhI
 Sdkg==
X-Forwarded-Encrypted: i=1;
 AKwUvByL6jbibgATTgP+4/fZAm1LIlKZH2vTGVjm/gQUT4dagt6ASBmGtsb5k9RAGJ6GdSE/gtEzw7c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lsQPOgXdqCbAVqbypFxbEK4oUgir3ReMJDZiArOmlGHwBU3L2e
 QQzbrEjwvsZXjU9BbvAZGsonJVr3Xo0q1AjVy8cNBiP/A8hUr8KFkLmP7/PK8Hyj7YnWtHtN6T7
 dYRajrh4ZR4kxRx1zwY8TSarCooZFs9I=
X-Gm-Gg: AYBFou07/SErHbEps38Wry+aG/ExnSzpZl62PCYhWsyAFKdWOdIvcsXdTUNo2mKahym
 pn9Y+5XvQFcEXhba6TTZH4+1AHCG3NcjWFD/3ct85vOu76l7mmDHQmEqvVGR+oHJwqS2u1dPxms
 9LKxRnzU4wW5t+xSpPmBiKeMe1/6aq9tzlSiGMgWJANtC7mm36DU/oDzep/Up3dKymDnbpDZHy4
 6NiJNRyG1h1rryE+3Bj+zm9iUx6Frgt1sqjW9Ie9FROWNp5zaxaK8e7iTXdAJIBE5C3JD4OH2To
 imJtiDyU59po+cSoJxVY4PUckC0ChjhY9AJ7z/dM2b6gBT4s2J0ZPlLleg==
X-Received: by 2002:a05:6122:d96:b0:5bf:9461:91d with SMTP id
 71dfb90a1353d-5c7d27b5697mr5479045e0c.5.1788445914913; Thu, 03 Sep 2026
 07:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-4-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:31:41 -0400
X-Gm-Features: AcwNN1XbfRJ4xMH6EFIRUZ6-AtpWCitAnJtAzQHGyj7RAMdq8mjPs1jL17SK0zk
Message-ID: <CAMDkj5xHZtyCtUYiOdE9-KPDr=qQiY7JqT5U_OE7W5OyuhB2ZQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/15] ecdsa: initial support of ecdsa using mbedtls
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Adds an initial support of ecdsa verify using mbedtls.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - rename sw_ecdsa.c to ecdsa.c
> v3:
> - rename sw_ecdsa_verify to ecdsa_hash_verify
> - stop on first group found
> - check signature len
> - use debug instead of printf
> - check function returns
> - fix memleaks in ecdsa_hash_verify
> v4:
> - move struct ecdsa_public_key from ecdsa-u-class.h to internal/ecdsa.h
> - use DIV_ROUND_UP
> - some code cleanup
> v5:
> - add kerneldoc header for ecdsa_hash_verify
> - read error when setting Q.Z
> v6:
> - add ECDSA_VERIFY_MBEDTLS
> - fix kerneldoc: doc not add a space before :
> v7:
> - no change
> v8:
> - add some useful comments
> - avoid using label such as out1, out2, out3 ...
> - code cleanup
> v9:
> - no change
>
>  configs/sandbox_defconfig       |   1 +
>  include/crypto/ecdsa-uclass.h   |  15 +---
>  include/crypto/internal/ecdsa.h |  39 ++++++++
>  lib/mbedtls/Kconfig             |   7 ++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 152 ++++++++++++++++++++++++++++++++
>  6 files changed, 203 insertions(+), 14 deletions(-)
>  create mode 100644 include/crypto/internal/ecdsa.h
>  create mode 100644 lib/mbedtls/ecdsa.c
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index b9991d269d9..63682ef0e74 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -390,6 +390,7 @@ CONFIG_CMD_DHRYSTONE=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
>  CONFIG_HKDF_MBEDTLS=3Dy
>  CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA_VERIFY_MBEDTLS=3Dy
>  CONFIG_ECDSA=3Dy
>  CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_RSASSA_PSS=3Dy
> diff --git a/include/crypto/ecdsa-uclass.h b/include/crypto/ecdsa-uclass.=
h
> index 189843820a0..047a5eda2fc 100644
> --- a/include/crypto/ecdsa-uclass.h
> +++ b/include/crypto/ecdsa-uclass.h
> @@ -4,20 +4,7 @@
>   */
>
>  #include <dm/device.h>
> -
> -/**
> - * struct ecdsa_public_key - ECDSA public key properties
> - *
> - * The struct has pointers to the (x, y) curve coordinates to an ECDSA p=
ublic
> - * key, as well as the name of the ECDSA curve. The size of the key is i=
nferred
> - * from the 'curve_name'
> - */
> -struct ecdsa_public_key {
> -       const char *curve_name; /* Name of curve, e.g. "prime256v1" */
> -       const void *x;          /* x coordinate of public key */
> -       const void *y;          /* y coordinate of public key */
> -       unsigned int size_bits; /* key size in bits, derived from curve n=
ame */
> -};
> +#include <crypto/internal/ecdsa.h>
>
>  struct ecdsa_ops {
>         /**
> diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ec=
dsa.h
> new file mode 100644
> index 00000000000..244a07d1f1f
> --- /dev/null
> +++ b/include/crypto/internal/ecdsa.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +#ifndef _ECDSA_HELPER_
> +#define _ECDSA_HELPER_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct ecdsa_public_key - ECDSA public key properties
> + *
> + * The struct has pointers to the (x, y) curve coordinates to an ECDSA p=
ublic
> + * key, as well as the name of the ECDSA curve. The size of the key is i=
nferred
> + * from the 'curve_name'
> + */
> +struct ecdsa_public_key {
> +       const char *curve_name; /* Name of curve, e.g. "prime256v1" */
> +       const void *x;          /* x coordinate of public key */
> +       const void *y;          /* y coordinate of public key */
> +       unsigned int size_bits; /* key size in bits, derived from curve n=
ame */
> +};
> +
> +/**
> + * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
> + *
> + * @pubkey: ecdsa public key
> + * @hash: Hash
> + * @hash_len: Size of the hash
> + * @signature: Signature
> + * @sig_len: Size of the signature
> + *
> + * Return: 0 if all verified ok, <0 on error
> + */
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                     const void *hash, size_t hash_len,
> +                     const void *signature, size_t sig_len);
> +
> +#endif
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index e019f17d6bd..66bc16db451 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -308,6 +308,13 @@ config ECDSA_MBEDTLS
>           This option enables support of ECDSA with the MbedTLS certifica=
te
>           library.
>
> +config ECDSA_VERIFY_MBEDTLS
> +       bool "Enable ECDSA verify"
> +       depends on ECDSA_MBEDTLS && ECDSA_VERIFY
> +       help
> +         This option enables support of ECDSA signature check with
> +         MbedTLS certificate library.
> +
>  endif # MBEDTLS_LIB_X509
>
>  config MBEDTLS_LIB_TLS
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 0c86c90d15a..b96db812afc 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) +=3D sha1.o
>  obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) +=3D sha256.o
>  obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) +=3D sha512.o
>
> +# shim layer for ecdsa verify
> +obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) +=3D ecdsa.o
> +
>  # x509 libraries
>  obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) +=3D \
>         public_key.o
> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> new file mode 100644
> index 00000000000..ca4e572e638
> --- /dev/null
> +++ b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +
> +#include <log.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include <crypto/internal/ecdsa.h>
> +
> +#include "mbedtls_options.h" /* required to access private fields */
> +#include <mbedtls/ecdsa.h>
> +#include <mbedtls/ecp.h>
> +
> +static mbedtls_ecp_group_id ecdsa_search_group_id(const char *curve_name=
)
> +{
> +       mbedtls_ecp_group_id grp_id =3D MBEDTLS_ECP_DP_NONE;
> +       const mbedtls_ecp_curve_info *info;
> +
> +       if (!curve_name)
> +               return MBEDTLS_ECP_DP_NONE;
> +
> +       /*
> +        * This curve name is read in the FIT metadata.
> +        * When this FIT metadata are filled by mkimage (or binman),
> +        * the curve name is the alias/name provided by OpenSSL.
> +        * And for secp256r1, OpenSSL uses the alias prime256v1.
> +        * So here, we have to manage this OpenSSL alias.
> +        */
> +       if (!strcmp(curve_name, "prime256v1"))
> +               return MBEDTLS_ECP_DP_SECP256R1;
> +
> +       info =3D mbedtls_ecp_curve_list();
> +       while (info && info->name) {
> +               if (!strcmp(curve_name, info->name)) {
> +                       grp_id =3D info->grp_id;
> +                       break;
> +               }
> +               info++;
> +       }
> +
> +       return grp_id;
> +}
> +
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                     const void *hash, size_t hash_len,
> +                     const void *signature, size_t sig_len)
> +{
> +       mbedtls_ecp_group_id grp_id;
> +       mbedtls_ecp_group grp;
> +       mbedtls_ecp_point Q;
> +       mbedtls_mpi r, s;
> +       int key_len;
> +       int err;
> +
> +       key_len =3D DIV_ROUND_UP(pubkey->size_bits, 8);
> +
> +       /* check the signature len */
> +       if (sig_len !=3D 2 * key_len) {
> +               log_debug("sig len should be twice the key len (sig len =
=3D %zu, key len =3D %d)\n",
> +                         sig_len, key_len);
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* search the group */
> +       grp_id =3D ecdsa_search_group_id(pubkey->curve_name);
> +       if (grp_id =3D=3D MBEDTLS_ECP_DP_NONE) {
> +               log_debug("curve name %s not found\n", pubkey->curve_name=
);
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* init and load the group */
> +       mbedtls_ecp_group_init(&grp);
> +       err =3D mbedtls_ecp_group_load(&grp, grp_id);
> +       if (err) {
> +               err =3D -EINVAL;
> +               goto free_grp;
> +       }
> +
> +       /* prepare the pubkey */
> +       mbedtls_ecp_point_init(&Q);
> +       err =3D mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
> +       if (err) {
> +               log_debug("could not read value x of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto free_q;
> +       }
> +       err =3D mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
> +       if (err) {
> +               log_debug("could not read value y of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto free_q;
> +       }
> +       err =3D mbedtls_mpi_lset(&Q.Z, 1);
> +       if (err) {
> +               log_debug("could not set value z of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto free_q;
> +       }
> +
> +       /* check if the pubkey is valid */
> +       err =3D mbedtls_ecp_check_pubkey(&grp, &Q);
> +       if (err) {
> +               log_debug("public key is invalid (err =3D %d)\n", err);
> +               err =3D -EKEYREJECTED;
> +               goto free_q;
> +       }
> +
> +       /* compute r */
> +       mbedtls_mpi_init(&r);
> +       err =3D mbedtls_mpi_read_binary(&r, signature, key_len);
> +       if (err) {
> +               log_debug("could not read value r of the signature (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto free_r;
> +       }
> +
> +       /* compute s */
> +       mbedtls_mpi_init(&s);
> +       err =3D mbedtls_mpi_read_binary(&s, signature + key_len, key_len)=
;
> +       if (err) {
> +               log_debug("could not read value s of the signature (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto free_s;
> +       }
> +
> +       /* check the signature */
> +       err =3D mbedtls_ecdsa_verify(&grp, hash, hash_len, &Q, &r, &s);
> +       if (err)
> +               err =3D -EINVAL;
> +
> + free_s:
> +       mbedtls_mpi_free(&s);
> + free_r:
> +       mbedtls_mpi_free(&r);
> + free_q:
> +       mbedtls_ecp_point_free(&Q);
> + free_grp:
> +       mbedtls_ecp_group_free(&grp);
> + out:
> +
> +       return err;
> +}
> --
> 2.43.0
>
