Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8F606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yvTzlQi0;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OTJffnpx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 794BE40A20;
	Wed, 18 Nov 2026 17:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGPZE-lUWxql; Wed, 18 Nov 2026 17:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A85440A11
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795024038;
	b=EYZPyEpmy8KmJHfxNPuKsXNs+AYX8JohG/rgZmaCH3jJmkppx200Y4AIkKD8uwefY8DU
	 DF0fBTEkk1goT0LNJblMhLhOcS+K87zhaMyCZnTOy/1hhC1ecYKcfMdYTs3SAc16zFQVv
	 45NkApWIjlgW/tusQ6CRY0wTIGZm7zox05/vbcXX2EXpL5FlxnThR40GksxkEaIybGwmO
	 4LXCA1VBjhRN3WhBg+sDEIZ9vzPwZrpmkmfXCGCjqTJelaGMCPrE7BO5VT4BFpnGCJDpM
	 w1yKDH+UQ4yQGH1NQOiczBd180VODLsHytpDoBjorSdCfp29iWSUX8WP6AKp0wpIieg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795024038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FROzSdtoG8xXcn1nJDIg7xDRRzHHqOlQ59ZZQOYyLaE=;
	b=T/4r45qFORGGxBj5eHdtPvcNJkD7TbT5zzZmt8R70KLE76InQs8pQukpt/wEmPNlrLFY
	 TzeO06NOmRAc5IjMRQ1s2UrEIiT6DZlkQGeBHZaklUBwWI2Tl72DFMcT5nAH0tK5+g0o4
	 lTlmBRKuPrYC50dDENaNOo4HNRZpDBQBFbW6gaRQlpmHWgcyP+CbhxmTdU2gwhdCMNHNG
	 XjXqC5fRD6XcM9GUvFbx/PDWZx6NEW4ORo9rdfZBP4zkzm83gaI4asC/L5zXu3II+yGwi
	 bHDPYs7BUmuliPMbwd2kM7e08kGfeixNFIelbbZzy6S6NXjs3iaIbdk42APrqa/zdww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795024038;
	bh=FROzSdtoG8xXcn1nJDIg7xDRRzHHqOlQ59ZZQOYyLaE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yvTzlQi0wIvqYK1GhVVO/gOf5JlE7HcES1SxJfeiVhaGVU5XJdXpD5zJrlLEu3UOZ
	 75c/qrM9Ow9+EGmhgwbVuAF/Vj7ckFXXxDgcqqWUestVrDuS69MNzgxBdQSCFD8WE2
	 ZU/cSwYkm4RWD3ItmTzXdkC19Fbt4Op2O8hX0b5+X3yb3LE82YQooRVHUFhIMoB+W7
	 KxCcETbzmPWTQvij8SMSQ0Qa3B7JJEfzdxytBSrro5/+tMGEyCgGeeSOM89FQqpc2O
	 7Km+x4R/INylAvTsH/41WFavHS2tgApQZXeftnXTmjqiLZ+iNaTm9Dh2QMpiev1E0x
	 HwwKDCxKSjyig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A85440A11;
	Wed, 18 Nov 2026 17:47:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 25D079F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1769C606CF
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9pXfhK5cTxzc for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:47:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB024606AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OTJffnpx
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB024606AA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:15 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso11852225e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795024033; x=1795628833;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FROzSdtoG8xXcn1nJDIg7xDRRzHHqOlQ59ZZQOYyLaE=;
 b=OTJffnpx/DhGHsnDY65xPKW7n/T06vAIS/gOcMRJnWCCJnLca9lp4Rql+u55HIRI6e
 Nu7z2lEp/A766/VBfQVxrGftHSzThkRFoU3BD6oP2YhjyNsuYpzjvfN3bkbxRkEPVaZL
 VRMddk6YWCUUIKQAn1iAU2RvwoajkpCjTvIJtI4eKdQ4CE1Qjz56k/rUFgIqsnHBj+S5
 pHYS+QXyCxHxiHBnHPI0snQtwoaW0jqtWGlGI8unaUm0ItMxjWhfxz1yt6bnjTgC7gQL
 uSr9B1cQP62DP2Fs1nogWepFSyNTRWBO7uUfYSbXGNID0zZgqRquWUn/84a0ivUKWC3Y
 B3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024033; x=1795628833;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FROzSdtoG8xXcn1nJDIg7xDRRzHHqOlQ59ZZQOYyLaE=;
 b=DyfvZhuRff0n5VN9cX1BqsuZYUfVU1YmRh7ffiTDgMOWW2TjHgkrmTozcXloOvffTe
 M9Ka+z5QcZoRc7Qas8yuUkb0qvxyiBIMW4LdGrJlnrkD99TmDQFoDhXHS7UoWsWC68r6
 M0jLpBgzkPp5+EIt+Hurey9wjhqLSciNkDGYcoZHOFvQIZiTlyLFadKU+ZeVw9PCx1FH
 RDHLB9GUW42RKdWOF/eCoFkE3wX6ct8qrJr0wZSNd4MuKm2eKTW8mHBdRiySYBQ28lyB
 j1WDXY/wLzKiSx7jwn2QA4oT3NYvWfs++EoY3LGupn3RbyA2zZI60TaGQ4Ufh+LMOE1W
 Fhtg==
X-Gm-Message-State: APuU4Z/9rocjBoNvGfFm/7SUaLhIB4M7iUbmuVjQ91rzF8jzlAgziSph
 HpPu0cdtuBUjHwSeBRRXFgdAucz7yhdFqllOlNOIuUeAjQPE3VUzYjFL
X-Gm-Gg: AYBFou03hhDcZgpxAesTb958y07ocDTriULtnH6nKW9SS8ADkKWzURXhuNzzVo+u8mx
 6dWlWvPVC8j7tlXVj1/eltSNrIGz9q3C4Aa4AAsbqFvvb0codwZg/mfytDSSWG6y0YUdW6aPw8L
 dYHUDfYdcWUMPTKQf5tCVNvozJQIK65hPPLWXYtcC807htjpBcuIkpH/JxcYjEHXe0TE1jvQJZu
 JPrwPH4w2udJ3OEelBzUSPa8/MZ23HqlHvgqA5v2PvhKUXSjGhd1AgD/rJ0TYgh34VQMrElHvWs
 RVl7L9cY/cIiT7xVdOIV+L6vW6ImpwxjicCJmrNPBXtbkdQNhmUyKv8kLsLzYFVv9QkVQhR+08Z
 0GgMV0KC5OBaCSmU09SiY2v5H2CNax2dRs1RbOK/O9xP7KIp+chNxezkRfBkPFSzbzotD3Nb2cM
 06Xrl3axelMwV7Oe8WsYWjS8Dkc9FLy3mCdUsLdJqpEMS7oB4FLo+WsLZ9vWxPu6rNptrMdUkga
 6K6zxKY8MJTep5jYppeKsif1gUzW9l7iaHDgap2Fq3NzeeYSqrPWNNvQkzbFYq471z1AYBESr7s
 7YLEUlZx7fNih94hGmoeOmb03dbpFpJtFoU7W1VP
X-Received: by 2002:a05:600c:468b:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb7d6cc2f4mr66284835e9.4.1795024033244; 
 Wed, 18 Nov 2026 09:47:13 -0800 (PST)
Received: from [127.0.1.1] ([151.51.238.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm6302789f8f.43.2026.11.18.09.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:47:12 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/4] mach-sc5xx: Generate LDR artifacts only if ldr tool is
 available
Date: Wed, 18 Nov 2026 18:46:56 +0100
Message-Id: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDk/WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3ZyUImNdI1NTE4Nkk1TDZEMTJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAKZyfJdoAAAA
X-Change-ID: 20261116-ldr3-25540c4e1c14
To: u-boot@lists.u-boot-project.org, linux@analog.com
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ldr tool, used to package artifacts in LDR format, is neither part
of toolchains nor available as a utility in common host distributions.
When missing, all of the builds of Analog Devices SC5XX SoC defconfigs
fail, including buildman ones when testing these platforms.

Indeed, the LDR format artifacts (u-boot.ldr and spl/u-boot-spl.ldr) are
final ones and not prerequisites for other targets. Therefore, consider
them optional and generate only if the ldr tool is available, silently
skipping if it is not, without raising any errors.

Align the CI Dockerfile, too.

Note: the only targets using the LDR boot stream format are the Analog
Device SC5XX ones, therefore the *.ldr make targets could maybe be moved
from common Makefiles to arch/arm/mach-sc5xx/config.mk. I do not know if
others have used the LDR format in the past.

Currently, the ldr tool sources can be downloaded from [1] and built as
done by the CI Docker image (tools/docker/Dockerfile). Alternatively,
install the adsp-ldr package from ADI repository as described in [1].

[1] https://github.com/analogdevicesinc/adsp-ldr

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Massimo Pegorer (4):
      Makefile: Drop $(CROSS_COMPILE) prefix from LDR variable definition
      CI: Dockerfile: Drop $(CROSS_COMPILE) prefixed symlinks to ldr
      CI: Dockerfile: Install ldr and clean instead of just build
      mach-sc5xx: Generate LDR artifacts only if ldr is available

 Makefile                      |  2 +-
 arch/arm/mach-sc5xx/config.mk |  9 +++++++++
 tools/docker/Dockerfile       | 17 ++++++-----------
 3 files changed, 16 insertions(+), 12 deletions(-)
---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
change-id: 20261116-ldr3-25540c4e1c14

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

