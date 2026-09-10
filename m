Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A138C79FBF
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7D2E81183;
	Thu, 10 Sep 2026 20:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6lNksSjeY_i; Thu, 10 Sep 2026 20:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 853F780F78
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070596;
	b=PmNuKTT4vuSCp3H8dTRSZQrl+4UcXg/NYzEoikaNib5BTHL4Retg1fJppO72M96IPlNn
	 l5kzlWbU8ijV6CbpLGZFkm8JjyfEfUPYSHpfYEwjcyeIPBpxfcqxhU8lvgcysy/z0Kup0
	 HBQkcN6JJpY1VdlVlMQlId8WSxGuBxoHOKR34jvHDK5olYh5wN1kJLjabcADyZQbGf88s
	 nwsDe0gv/u8fdGEQf3rZ7XzfuSHmOImt+/9qZCWwJAp4kyu4Yn4fAFc+sXLMZjy7kHMIe
	 0oHkiI8B6I4Ng46sEqd/HA6ouh7TNH3LthMI3KFna0Swv/tA6Rg/FZvqi0EypwOAgYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U59IswCkFoPGlNWhovB3hT8IG9f66vJ0zphlGyTD5sg=;
	b=Tk1tgxhCXS9XQRRTLvhT+U76JCTULvARfR8+5y/EzKFp2B5iG1hDTGAkcFsFVO1FkKSp
	 PfWc7Zupd4pFeKu7e1wrEoFj1LnMqMD/42/ztFAhj3V1XZ6k/4eqwul03QwGEC6Nv9kDz
	 ER2/s35PK0Ez2qsN0PeOpzg6KEn4csUeCp1B/+rtyTB3YMSuzYgKh63dW+mpZv0DMzKhT
	 O/cx35ktEK4hgtFTWwu2v2tKljGwuscmnR9rcLhNxTXJ+/6BiCapbjZES/Qyl6gfUfDxm
	 QhEuNXu8H7i7ZbHJ5qWL6marxQNuOeqcCW5SYfEXzTd0CmN+bK92y0iMITky+U88Y+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070596;
	bh=U59IswCkFoPGlNWhovB3hT8IG9f66vJ0zphlGyTD5sg=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c3LP/EuIClL+7wNo/iMuQvN2hnnUwVse2Abxrw7ExldHrelzbDUVc6sA0hn/bYHfF
	 ZA9B7ZnH74Q3tmRsgcaYgJ+WXxRornIfdy/LKO9Zg56rPs6H9fkUDtzEJG6mJM00tX
	 qcqrhY5Dd2niGcZrGs8MrTfQW9mei4S8U2jqlGxMXcRGH1HyJWtVznEOWYUaZSaMoA
	 zAJJYwaByhPSii4qKPYxPJ7jUwKWx2LY4y2v4GS37Z/KMnOTRyjWpUCVp5bQP0cUMn
	 spmPvhA912pYCPRQVsBH2wotqiIFiLem7cbRzMCxVVwl6TxMbXcRXc4MHCHoRZaem0
	 jKOowlUBlNnSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 853F780F78;
	Thu, 10 Sep 2026 20:03:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D562914D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB29640B10
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxHjtKaUT1JB for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D49340B36
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070594;
 b=b2Q9Lfjf6LAwrVB1POv+s9HgSL7XS99qyEAZo3vHuhJy/RwDVQaivgYOxuWCKDg8IzUU
 z5q0VgkT3DsVoBs6FgkTx4wlGXTmpKymDp4Df1+WR9Os/wDo88pRWRDeJNnmd9cgdKmVn
 vnNAy4iLxguNwIrILR87hq+sPmpzyZ1Sp00EWUp+yd3SsHjkQfXoRHTyo8idA5BboATI+
 H5lGa1nA9sRveWTbaepN+s/lbE8jHVel+YZRAfNgfwJPdr06ZIsv0a5s1pYY1UDJJX1hb
 A1FqP2xM+luR+WQ/oPBU7ICMrf/NKaflXbSRlMtBCHDM7E+pCJYbMTjo0voRR4wrG6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070594;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=U59IswCkFoPGlNWhovB3hT8IG9f66vJ0zphlGyTD5sg=;
 b=L5qN957dC0URTwzMGKOBBHFizudtjZyq6pMStVLknHF6PeisvCK5fQ3e9MZhLfIURP1m
 2EMVEgglAi/XKfWDD1PngkHN8qDgdmdgLLMvyTPLziJ6dlt0Mn+M6muXsAhW6aqYj7tst
 86Dr9LhnODOULTjcipYEBb3J5epBEPgvdwu/gNldIO3iYhHOMFrjq6rjdFlklz5io88qk
 Ie3O5s9W9wfIG+4nQnMDpNU/8AURS5Gfguw97ztIBpVCvSovqrPar5wGE9gH91JXpTuwW
 MOb1k0zK9CezeibK0PMmX1byBNhpfO1GDzWTYBB60v1C7Kc+G1WAovQzHrWWxUe206Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DAKQeHZO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::4;
 helo=mail-oi2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DAKQeHZO
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D49340B36
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:14 +0000 (UTC)
Received: by mail-oi2-x04.google.com with SMTP id
 5614622812f47-4b38a6e8c79so79819b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070593; x=1789675393;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U59IswCkFoPGlNWhovB3hT8IG9f66vJ0zphlGyTD5sg=;
 b=DAKQeHZOXHlyo7bol3Qv4mmpd8W13bzCGln4+IYjizav23RVd/Rg6ywzpu01e+Hkzq
 /KNl4ZeUtso07XafYoQ+zcNhyk8xrigaxjLzpz+DvrLUN20imLlRue3ceq+Ubm47yqLS
 agOZSpR2EPlqgp5EUAUDoYRoqLVIghbbJoKPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070593; x=1789675393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U59IswCkFoPGlNWhovB3hT8IG9f66vJ0zphlGyTD5sg=;
 b=dQMfphJY0WiMweILUl2U+OdZIk1JhLVqiKGEbMkLLLuVYHAUkShT3T3XcLXP3kO8o1
 KPZb2STK4T09tk2o8OsmAwU3oPFQSG7UnpQFztFmchJEVNuj8t2erKG1KLYvU5avhAfg
 ErBhJVF/Q1EPThFLwLcsM9cu3Qelod+GTg6ps7klEn7bbL/WBeRhoy6rtd+ESycgXkY0
 M/WncQwnZTfQPiq4q+glQwqphA/CeZeiAkR/f1JVj+q56tOAfORpyeniEsVvaxnRFXyl
 a9Cua2WU4Hyuq7aI8KE8HS6D3g88PrOQYQkn9pO6Sg9mBgOTg1HGphVwvxrgyHRpVaJi
 EIBg==
X-Gm-Message-State: AFuF++nZUtkWe3ZDQil0ckfOQWkHpavLRnrDNXTJx90KWAsWmsz0NDUv
 EAd5mc96w7GInc+i6SYmJ+5VQC4LfXpeFWbP/UCvry8qdS2QKx47DZLP1d7CVudsVeHL/HbQ2Dc
 YH4zBFlfg6xff0r4=
X-Gm-Gg: AYBFou1K87Vjrg0/xlr3UK1quoDNEkGqHY92C4TzbDZpF+32YxrsXMpuOlpPVPZcUhx
 D3GkPphPKHYL4zaGRY++zS/K91jiMGgDXRY9GlySqfomjowZJVYmvFQGnA+MaksT4s//nXl8YQ1
 YpVZN3m0gs2vwDAlOdE9q2JB80RGaDwN7T3ZR+QqbWZggPXYEVqFF6Wgd0x65Uhx3jMaiJ0ZlAg
 zUokgZi047mfZrjaSOdrWZgELlgRubCv8GGefYwCkLyxLMfRC6Zljc5Bp17tp062rYP0mGejkCI
 oaJaZMCY0khCvrg25SYq3y5oF7D4hzekA6yfgwL2+UktYWjJwtqUFp+f1d86gdsgbD6t1rPW8FR
 YyLd52HIBUwiXEuaH9ufXuMn1jKHR34t+KOLq+/bVJXre6U8g+hqZwSIqJLnU/EujsHx+9F8MJW
 TqeBscOcfWJVROn5EHSyM94tmhJxAp4znrKiOD150Wm3Kz4TijHm6pWeHgwSIf2iF9sBWK8Eb7t
 LmwN9Eajw/uHLoyLCWJvT1R2GHkGddndtgHfjE6DYNDvDofY1/H54aLXtjOGs1GXx6fYgGr5KMm
 59m5KiLPnWMZa7V27flUxHBbGmsatY+eRaYChUh8308MJ0/urT2OmAw=
X-Received: by 2002:a05:6808:50a5:b0:4b9:e65b:8c36 with SMTP id
 5614622812f47-4c31c72c208mr505498b6e.36.1789070592978; 
 Thu, 10 Sep 2026 13:03:12 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.11
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v3 0/7] Cleanup MAINTAINERS entries
Date: Thu, 10 Sep 2026 14:03:02 -0600
Message-ID: <20260910200310.3503830-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This is a v3 of the series Michal posted here[1] and v2 is here[2].

As the diffstat and previous versions show, we end up touching a lot of
files. To avoid having a huge series, and also to avoid unmanagable CC
lists, I've broken this up in to 5 patches. In the case of updating all
of the Tegra entries, a little more work was required to ensure
consitent coverage, so it's a separate patch. Also, as there was a
question of ensuring that new -u-boot.dtsi files would be caught in one
case, that is also a separate patch. The final 3 patches try and group
together the cases of:
- We know what file or directory should have been used, correct the
  entry, it was never in-tree to start with
- The above, but MAINTAINERS was missed in a rename, so fix it now.
- The files have been removed.

With all of these applied, we have a bit more coverage than we used to
thanks to the corrections and now the tool reports everything is clean,
so we can have CI ensure it stays that way moving forward.

Changes in v3:
- Applied tags, reworked Tegra per maintainers request, and rebased on
  current next branch, which means dropping the TI portions, and adding
  some newly removed files to that patch.

Michal Simek (1):
  scripts: Check F: entries in all MAINTAINERS files

Tom Rini (6):
  MAINTAINERS: tegra: Update and correct entries
  MAINTAINERS: rockchip: Use N for rk3576-nanopi-r76s
  MAINTAINERS: Fix "typo" and similar incorrect entries
  MAINTAINERS: Correct entries missed during renames
  MAINTAINERS: Removed files
  CI: Run scripts/check_maintainers_files.sh in the existing MAINTAINERS
    job

 .azure-pipelines.yml                          |  3 +-
 .gitlab-ci.yml                                |  4 +-
 MAINTAINERS                                   |  7 +-
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  2 +-
 board/CZ.NIC/turris_omnia/MAINTAINERS         |  2 +-
 board/LaCie/net2big_v2/MAINTAINERS            |  4 -
 board/LaCie/netspace_v2/MAINTAINERS           |  6 --
 board/Marvell/octeontx/MAINTAINERS            |  3 +-
 board/Marvell/octeontx2/MAINTAINERS           |  3 +-
 board/Synology/ds116/MAINTAINERS              |  1 -
 board/acer/picasso/MAINTAINERS                |  1 -
 board/advantech/imx8mp_rsb3720a1/MAINTAINERS  |  2 +-
 board/advantech/imx8qm_dmsse20_a1/MAINTAINERS |  2 +-
 board/alliedtelesis/SBx81LIFKW/MAINTAINERS    |  2 +-
 board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS  |  2 +-
 board/altera/stratix10-socdk/MAINTAINERS      |  1 -
 board/amd/versal2/MAINTAINERS                 |  2 +-
 board/amlogic/p212/MAINTAINERS                |  2 +-
 board/amlogic/q200/MAINTAINERS                |  2 +-
 board/amlogic/s400/MAINTAINERS                |  2 +-
 board/andestech/voyager/MAINTAINERS           |  2 +-
 board/asus/grouper/MAINTAINERS                |  1 -
 board/asus/transformer-t114/MAINTAINERS       |  1 -
 board/asus/transformer-t20/MAINTAINERS        |  1 -
 board/asus/transformer-t30/MAINTAINERS        |  1 -
 board/atmel/at91sam9260ek/MAINTAINERS         |  1 -
 board/atmel/sama5d29_curiosity/MAINTAINERS    |  2 +-
 board/atmel/sama7d65_curiosity/MAINTAINERS    |  2 +-
 board/atmel/sama7g54_curiosity/MAINTAINERS    |  2 +-
 board/atmel/sama7g5ek/MAINTAINERS             |  2 +-
 board/avionic-design/medcom-wide/MAINTAINERS  |  1 -
 board/avionic-design/plutux/MAINTAINERS       |  1 -
 board/avionic-design/tec-ng/MAINTAINERS       |  1 -
 board/avionic-design/tec/MAINTAINERS          |  1 -
 board/beacon/beacon-rzg2m/MAINTAINERS         |  3 -
 board/bosch/acc/MAINTAINERS                   |  2 +-
 board/cei/cei-tk1-som/MAINTAINERS             |  1 -
 board/compal/paz00/MAINTAINERS                |  1 -
 board/compulab/trimslice/MAINTAINERS          |  1 -
 board/comtrend/vr3032u/MAINTAINERS            |  2 +-
 board/comtrend/wap5813n/MAINTAINERS           |  2 +-
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS   |  2 +-
 board/davinci/da8xxevm/MAINTAINERS            |  2 +-
 board/embest/mx6boards/MAINTAINERS            |  1 -
 board/engicam/imx6ul/MAINTAINERS              |  5 +-
 board/friendlyarm/nanopi2/MAINTAINERS         |  2 +-
 .../gardena/smart-gateway-at91sam/MAINTAINERS |  2 +-
 .../gardena/smart-gateway-mt7688/MAINTAINERS  |  1 -
 board/gateworks/gw_ventana/MAINTAINERS        |  6 --
 board/ge/bx50v3/MAINTAINERS                   |  3 -
 board/htc/endeavoru/MAINTAINERS               |  1 -
 board/imgtec/xilfpga/MAINTAINERS              |  2 +-
 board/intel/agilex-socdk/MAINTAINERS          |  1 -
 board/intel/agilex7m-socdk/MAINTAINERS        |  3 +-
 board/intel/n5x-socdk/MAINTAINERS             |  1 -
 board/keymile/km83xx/MAINTAINERS              |  6 +-
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS |  1 -
 board/kontron/sl-mx6ul/MAINTAINERS            |  7 +-
 board/lenovo/ideapad-yoga-11/MAINTAINERS      |  1 -
 board/lg/x3-t30/MAINTAINERS                   |  1 -
 board/libre-computer/aml-a311d-cc/MAINTAINERS |  2 +-
 board/libre-computer/aml-s805x-ac/MAINTAINERS |  2 +-
 .../libre-computer/aml-s905d3-cc/MAINTAINERS  |  2 +-
 board/mediatek/MAINTAINERS                    |  3 -
 board/mediatek/mt7981/MAINTAINERS             |  2 -
 board/mediatek/mt7986/MAINTAINERS             |  4 -
 board/microsoft/surface-rt/MAINTAINERS        |  1 -
 board/myir/mys_6ulx/MAINTAINERS               |  3 +-
 board/nvidia/beaver/MAINTAINERS               |  1 -
 board/nvidia/cardhu/MAINTAINERS               |  1 -
 board/nvidia/dalmore/MAINTAINERS              |  1 -
 board/nvidia/harmony/MAINTAINERS              |  1 -
 board/nvidia/jetson-tk1/MAINTAINERS           |  1 -
 board/nvidia/nyan-big/MAINTAINERS             |  1 -
 board/nvidia/p2371-0000/MAINTAINERS           |  1 -
 board/nvidia/p2371-2180/MAINTAINERS           |  1 -
 board/nvidia/p2571/MAINTAINERS                |  1 -
 board/nvidia/p2771-0000/MAINTAINERS           |  1 -
 board/nvidia/p3450-0000/MAINTAINERS           |  1 -
 board/nvidia/seaboard/MAINTAINERS             |  1 -
 board/nvidia/tegratab/MAINTAINERS             |  1 -
 board/nvidia/venice2/MAINTAINERS              |  1 -
 board/nvidia/ventana/MAINTAINERS              |  1 -
 board/nxp/imx93_evk/MAINTAINERS               |  1 -
 board/nxp/ls1012afrdm/MAINTAINERS             | 12 +--
 board/nxp/ls1012aqds/MAINTAINERS              |  1 -
 board/nxp/ls1012ardb/MAINTAINERS              |  3 -
 board/nxp/ls1043aqds/MAINTAINERS              |  7 --
 board/nxp/ls1043ardb/MAINTAINERS              |  6 --
 board/nxp/ls1046aqds/MAINTAINERS              |  7 --
 board/nxp/ls1046ardb/MAINTAINERS              |  7 --
 board/nxp/ls1088a/MAINTAINERS                 |  9 ---
 board/nxp/ls2080aqds/MAINTAINERS              |  4 -
 board/nxp/ls2080ardb/MAINTAINERS              |  6 --
 board/nxp/lx2160a/MAINTAINERS                 |  2 -
 board/nxp/mpc837xerdb/MAINTAINERS             |  1 -
 board/nxp/mx6slevk/MAINTAINERS                |  2 -
 board/nxp/p2041rdb/MAINTAINERS                |  3 -
 board/nxp/t104xrdb/MAINTAINERS                | 13 ---
 board/nxp/t208xqds/MAINTAINERS                |  5 --
 board/nxp/t208xrdb/MAINTAINERS                |  1 -
 board/ouya/ouya/MAINTAINERS                   |  1 -
 board/phytec/phycore_am62ax/MAINTAINERS       |  2 +-
 board/phytec/phycore_am68x/MAINTAINERS        |  1 -
 board/phytec/phycore_imx8mm/MAINTAINERS       |  2 +-
 .../polyhex/imx8mp_debix_model_a/MAINTAINERS  |  1 -
 board/qualcomm/dragonboard410c/MAINTAINERS    |  2 +-
 board/qualcomm/dragonboard820c/MAINTAINERS    |  2 +-
 board/qualcomm/dragonboard845c/MAINTAINERS    |  2 -
 board/qualcomm/qcs404-evb/MAINTAINERS         |  2 -
 board/renesas/blanche/MAINTAINERS             |  1 -
 board/renesas/eagle/MAINTAINERS               |  2 +-
 board/renesas/grpeach/MAINTAINERS             |  2 +-
 board/renesas/v3msk/MAINTAINERS               |  2 +-
 board/samsung/starqltechn/MAINTAINERS         |  4 +-
 board/seeed/linkit-smart-7688/MAINTAINERS     |  1 -
 board/siemens/iot2050/MAINTAINERS             |  2 +-
 board/sifive/unmatched/MAINTAINERS            |  2 +-
 board/sunxi/MAINTAINERS                       |  2 -
 board/toradex/apalis-tk1/MAINTAINERS          |  2 +-
 board/toradex/apalis_t30/MAINTAINERS          |  3 +-
 board/toradex/colibri-imx6ull/MAINTAINERS     |  1 -
 board/toradex/colibri-imx8x/MAINTAINERS       |  4 +-
 board/toradex/colibri_imx7/MAINTAINERS        | 12 +--
 board/toradex/colibri_t20/MAINTAINERS         |  3 +-
 board/toradex/colibri_t30/MAINTAINERS         |  3 +-
 board/toradex/colibri_vf/MAINTAINERS          |  2 +-
 board/toradex/smarc-imx8mp/MAINTAINERS        |  2 +-
 board/traverse/ten64/MAINTAINERS              |  1 -
 board/wandboard/MAINTAINERS                   |  2 +-
 board/wexler/qc750/MAINTAINERS                |  1 -
 board/xiaomi/mocha/MAINTAINERS                |  1 -
 board/xilinx/zynqmp/MAINTAINERS               |  1 -
 board/xilinx/zynqmp_r5/MAINTAINERS            |  2 +-
 .../orangepi-5-ultra-rk3588/MAINTAINERS       |  2 +-
 board/zyxel/nsa325/MAINTAINERS                |  3 -
 scripts/check_maintainers_files.sh            | 80 ++++++++++++-------
 137 files changed, 130 insertions(+), 284 deletions(-)

[1]: https://lore.kernel.org/r/cover.1787555916.git.michal.simek@amd.com/
[2]: https://lore.kernel.org/all/20260829015026.473134-1-trini@konsulko.com/

-- 
Tom

