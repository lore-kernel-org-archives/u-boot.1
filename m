Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780660A261A
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N2GQeHl9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n69wrrr3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53C8560871;
	Tue, 10 Nov 2026 18:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQkc7GyYbOEz; Tue, 10 Nov 2026 18:30:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD01960874
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794335419;
	b=nj/fp0vw6WeFPzgsFQ+qe0wNcPBslacAcp0dA9iLI+SiWHpLa3XRrcLv1ZRnN0dJJLGF
	 IU4AmJh3nlnomOyZIvRjLLkdd/puPr1oKYPU0j6t1eCkP+sbHcbtif1a8+cgeGZubmAhW
	 EtEku75tl/KCwfsQWWw79lraCDQJ4i/dKDHh+rWtVLaomtlKL5Db/koeBmcokVN9/Mc2F
	 0DULffjh2eBtEQ2FuoIo4+fmdhzy4gF0Dria6sWFPdSiecGkbwClkUbe1ljcyRQF180tq
	 viQCKEeaCU320224Gp3yT4Gi4IkbEvMynMJOAY5ZWHo1nouGoLa5JNH1pej8Ld1aEFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794335419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wSGwqPwZkFrUNNle+w7tvwOihKomw3saPwokRBw57L8=;
	b=huQTjMiXsahMMaV936ikBOSe+MD/0vefXS2xmgZ9oske+n1bOsa5YE4fK5hCXEstJMj7
	 mFfHvEKtaBNWD9VfT53B/Je1Bra3Cn9QSkn+inUk0qhIsaVo/H61g1QCI7gp56rmGrIL8
	 IAbGeNF9i3ukK885ZBnjBn3B9LLiMUBOjdmuYgNG1BgMS72nx4G01/EibshaAvcV0X8PN
	 YH7tDGMZNqz/GWAJmZbNjegT6Flpb3SXYt+Y0KxwmzgFl9iynBJhDvg/BUPT+KjjQ4/KL
	 ecojuvYoTTptz6owRY0Gc9PGwZPW3rn1JzsxvDSOef08M3m7oQp34U288ngiUNG2dxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794335419;
	bh=wSGwqPwZkFrUNNle+w7tvwOihKomw3saPwokRBw57L8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N2GQeHl9D9ZpFT9iUa87dCLkrwxTqk72divBD8/43RRMeN78Bm0A0MNo/CaKlY1UE
	 7T1oylaBfSNOsuUaHX9RZQdrCeCH8hQ52JttrQiUADLWF1hta53gWPQFpTZi7we6Jf
	 9PQOTfjTaxJ9iwIKU1jo2wYtZdGChLb9k+yx2rI30OKYcXXjwj9V9NnH/z0OI8cqSB
	 TOzYzXd+AiJdXQ7yyv3rYFdTvBE5lgZRaoyzqYpTr13kdzEjATUEubHdZJUZFnMdtZ
	 oju2Dl+XfdsL69JrsdvtyseSrXwh6zo/3ozGv3GTSRlkvO2+QlgtBDq83se+zyIMHv
	 HD6Brqqmhezlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD01960874;
	Tue, 10 Nov 2026 18:30:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC04E1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A15184030A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vto3wucwCKL for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 18:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B6FC3402B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=n69wrrr3
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6FC3402B0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:30:16 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5c1479be604so1574667e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794335414; x=1794940214;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wSGwqPwZkFrUNNle+w7tvwOihKomw3saPwokRBw57L8=;
 b=n69wrrr3kERSDe+EJH/oGciqGa0jXDv2kspqNosH4avnF7Cj3MGFMOf2fC2ERtnroG
 8tzqqyIOB6bjJglSciIVZpuxYOYrF0rnNZVElx0lVSsFLlvtFjom5EtV5rIQbV+7aMF+
 hEpkC3Ao5LJnTgoXWEHCq6mV7Vt5udFuPQId5NPUi5+40znebqcfRwWWvlsfbrmo4r4h
 zdOfOJYYqCcyEm2ylXCAzzScAXKvsL+a1+1np7HSKwREycdnM9fN+C9bIl5TSVXbvvcy
 UI1x2tTzQtI/ORWNkFRFjFZwaK21iB9BEIZlu/yoZSOQaP+RlcW7bss6qNlfQVWPg813
 5ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335414; x=1794940214;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wSGwqPwZkFrUNNle+w7tvwOihKomw3saPwokRBw57L8=;
 b=xfZsRB33UDeOhPKMgg6DoMYVGJrpZKdB0jeejSR3gubS+NCot9P4ccQg6kHQXlvTuk
 g1sECIF9U4yUtqaW9onLHoKHcinPlpK5Q9iLKAO0Xlh85vhW57vhv0K1J4DKZ/DR0qJm
 Dq8XNQY6ydM3xNkrHHs5NAE5bRV3T67iKCbrIyU3HR6nwlPjYjjeqAog1rZBhlEWYMxL
 zf/j1uTZuHPA2z8n4HLQnYMVtsNZBIaYuzr7AHnOKVOiNCG078svH/OZJc9x/jDfShx+
 uViHyaERj2f6p6BwOdD02mBHCHxfHa7bJZmiDoNH6ITG5igLtxrDWTKea6CnNE5my00E
 WJnQ==
X-Gm-Message-State: APuU4Z+HvJZzAleaJlXEpp/RQ9yJ/d2BttnlwOJDn/4Mun/Utfpjr5b7
 98BVPES8k+tJTGatpGv31YeS9td1P73HSd2GbQI+1JwQj+MaGsilQ+Np+tm729GnQbZsU+teCUj
 VsAnvzTFajVVy2BcCEm0U7oqAenL6ulo=
X-Gm-Gg: AYBFou3XScNd9mI358HZ1JZDIFc3fMCZdWq7vdC3MDHTWE61xak+Ysb1tt5Pn+PhLtF
 S4qCQ3Dvd3dlUfGozyyOtS4ml25spzC5dDHw5DO94LuazeG0U5O894vsVSzT6HIQ/N27d5/cs62
 Us63HFM4+AyIauBoSlyX6zT4CuLmMqvUsR1EbmS2SoY3ZrAUkJ4UlF8oTmCllUOE1EC+KP0gsut
 uKrZppov03vBOQ54uFzbtZmXHOHTFgKyZkAkMjdrjdcn46P5UQ2+W4BznxLu2G/XsX3gj/4qh44
 g7OMdn5DcEIaQuL3kCaYJ8P3Jg6sD/4q/xb3eB3UnIlhV/ybOxcs9LNirKxHHVnwygEeRZYdz7M
 7AtSmcqx4BU+vm5pVVN7k/bkXdTYg/SoOmDeSk1cMAECLRB3iEgz9d8VS0VfQ3mk5zPlrsJhna+
 HEeNgeIJ7PJBIXJJautSdg/aZQUHwVG0tjdjasX51PSsItjJU=
X-Received: by 2002:a05:6512:1306:b0:5ba:3c46:bc4e with SMTP id
 2adb3069b0e04-5c156ed7ffdmr1121460e87.47.1794335413515; Tue, 10 Nov 2026
 10:30:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260902163748.1003274-1-marex@nabladev.com>
 <a6365f6f-b87c-4d6a-8be3-c315931bf36b@nabladev.com>
 <CAOMZO5B=PRD-miBT8HASshW5FaStdVGXDx9Vxbnw19z9Afwzjg@mail.gmail.com>
In-Reply-To: <CAOMZO5B=PRD-miBT8HASshW5FaStdVGXDx9Vxbnw19z9Afwzjg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Nov 2026 15:30:01 -0300
X-Gm-Features: AclHuK_y5ifR-u2tJkROYk-kOcWFtkbrMhO1u67RMsJGYnI9ndWlYsTZITRPByo
Message-ID: <CAOMZO5Aff7dXwXjRr7Tk7JwsjXcJ_UVvAOeas6tKMcJnbf4VTQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Switch Data Modul i.MX8M eDM SBC to
 OF_UPSTREAM
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On Mon, Nov 9, 2026 at 11:09=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> It will be part of my next pull request to Tom.
>
> Sorry about that.

This patch does not pass in CI:

$ ./scripts/check_maintainers_files.sh
error: board/data_modul/imx8mm_edm_sbc/MAINTAINERS references
non-existing file: arch/arm/dts/imx8mm-data-modul-edm-sbc.dts
error: board/data_modul/imx8mp_edm_sbc/MAINTAINERS references
non-existing file: arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
Cleaning up project directory and file based variables
00:00
ERROR: Job failed: exit code 1

I'll fix it locally by removing these two lines.
