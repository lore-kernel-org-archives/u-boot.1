Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E12606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qv9CQvu1;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JkCgC+Gl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D1B14073C;
	Wed,  4 Nov 2026 10:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 86XjT8hLRzJ1; Wed,  4 Nov 2026 10:59:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02EE14048A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789966;
	b=SBxWMPLXuYOvol32Rv0McVDP4O4hYjUod+34Sd8FhoHfHAOh+5J66pKA0nKhh5rdr0gt
	 rtFO3bkRobPDZDP9zyBMQCB9+lJky8ISx3/eIxMpHV2227anvBCvjgl3yDkRo+/Yaw4ui
	 dCBv6p7tma1phZOtkOyQfp2GrFqP/ZCMG0pMY6kbnmtAjklEHP+jA0pqbPZhWqqU3EfjX
	 JE3hYrWXVQPi5VIaKGTFQ6UbAze79oKkAFDQdNl9zfhTD2DualBpAsgYg8MAOOXwCuRvm
	 ybQhwRwTqoXDd1/uPetsGpfQF6KbdhNMrSYi00s0Tc5OYiQaacDFyZxOC5AJ9a/YPEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=reGs5kGHa+NH9dH8+E6+duLEU2jDy/1CGbYuGT+I8BE=;
	b=BszYMQuq9WMigKH1J00elp3pObQ4mF1On4c2rrTPQqnHScfnubnI+UrRfGB73iLiCW2L
	 IWE8cnfWP9WZQ8RGBIyECyRBjhUWFgvrhyEJOaVAGIlyHujgvFJXM2KmuFWTFdpEfYjDh
	 52E8kw/xYnDYYDtI3MeLRmZIwxT08/FaegxfNYf9P9mRGEm5OvA44P/CKCnHQGiBWf116
	 fLhF5yUAh3TUHk8YLCrGu4apHLtyr7FHUSsXKwZOcXCtUj2Zo+cj4USADi5u4TzY7WYlC
	 Ha9RzsjcSqJ4mrcQqfITnT2SN6M/J2LirF4cmIaED1PPcGH9HnECiLpaTNv1z8IdwUQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789966;
	bh=reGs5kGHa+NH9dH8+E6+duLEU2jDy/1CGbYuGT+I8BE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qv9CQvu18UH6Ech4yLn80Fy0JtU6UrwUQnj2v+LiCjBvM/JDQJkWlEatLTHymUuVt
	 JOO7GeAuL3xAm/MDfOTlHsDeyLfbobD2bnKyzluRa44r+DgBhPlzzq9U2EPjcpL7nH
	 VBdi6cmZ9ARStXu93IITcjNND6Rggtvx/Ta6O6lgX6gSa47C0drDOqLfMwKRzWXsDu
	 rMLIJxvo59jGCW5axMk/xXmaysX4PAyPEZTCEUTMjlDEb9BB+QdbQea8PYeVr5NPBX
	 rnqv4K22iwTG2j4OojjNzYvE3cuBf/3C46ToeAtOdH6d+jIiA6U9ocDi+bC6G8z4Xr
	 v0IpqA2aZlmVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02EE14048A;
	Wed,  4 Nov 2026 10:59:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48223A14
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E70280F6B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORzQ13kOoHHj for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7825D80F61
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789961;
 b=hMe+uLP/WZmgMpZyqvjriN7loguUus9kOlgfzSjc8hygoFw0sZVhc0sw23GFOZX4TsNf
 Q/YWCWb1DM3KWamgC2Y2ZYXyWq1nsPyO5b1aoNMiGcaoisOJJxaGp00uGJ6uRq2K6vWjj
 vk/Mc/BVuUeEi3r4khGllZGIfcQtDpIfra/wHGp7esT2osMSUAGKw0jmEAyNqfuUHZxc+
 Hy6SHWA93GeHyf9CdUEvBHQ9duu1Wndk67TczRNutvR173s0kBvzHtqvJUmodvbq+UMLa
 dHkgA2wsaVfgHjicZXZB6jJrs6yN8FZ0HRQsC4upgqh6WDEpLBLKnre9CCjBaEwWu9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789961;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=reGs5kGHa+NH9dH8+E6+duLEU2jDy/1CGbYuGT+I8BE=;
 b=rrtL/CUjlvULJb1XLo+E67AewWdQkT+s7Zws2VPzNhFWTeWCiK9bhDfE+/XJIkb6iyHq
 FbfMWzx1x0vCJO8aLCN/vib40diOCSuIvpP1ye6R1WlMoJY32lqYdlFmwcwbKsDUMaMdQ
 ysbFNQZmkL6OJsZf+pIRTHciGeAxai9CJu6i69cT6C66JFJFpstFjuestDQqOcLEQRXuO
 Dz2U2LgKOz5KT0Y0gxiaM5nXEUjF+R3o6qL+Xf596bWCwWILCDPxZVcpfWcfdT7Csu8lv
 M9kHR9kqmZvl0sM1HglSwQ9HCLG9y+A0ydURsx1FP0MLFy9MUYawCBJDFM3AsE9wWBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JkCgC+Gl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JkCgC+Gl
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7825D80F61
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:19 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso379599f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789958; x=1794394758;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=reGs5kGHa+NH9dH8+E6+duLEU2jDy/1CGbYuGT+I8BE=;
 b=JkCgC+GlqQPey+Hzw4oITbb6It9ZafN3IH5zy2YiKYeun0Xm0ZHGUnK/5HMnGflJPa
 Lx5/1ezEqZW+E7G8JcdON7g4FDoZifvIn2ZwY4UEGatNodG60iuekTWWz2yA80lgZ4Hy
 wtLA/e6Fg5RNiZwC5G/eZCoDnKghupibdfJSWmuGiDT9rEfM9P9H99IMoNSgG8+KPp/y
 D1QUTwxoQjaga//OT0CQ3j9lxbMSvXPjtlLzlMp2t8Okt2CdoL+BXnbReGV2EJwezttB
 fLCKSS0k6Xzvr0EweHrHGcwjYbmIo9wjuvK9utx41ZVKKZlpbIAoa2EifhYT7yGuYhMW
 RauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789958; x=1794394758;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=reGs5kGHa+NH9dH8+E6+duLEU2jDy/1CGbYuGT+I8BE=;
 b=wEZKdyyWvfPXvVgCB2vH12dw6aWzeQByWqqBjTnG8ezu+aEpURVpBW+Qt37JElMxXf
 W0poml30Zuc2go+ZVl5bhWjf7qr6eN42WsNvYG0ewHbCZSd+J+xoc72/1hFp0VQkR/Xp
 I1fp9zl1wNm2LutUla+TPdoAt1bl1lP4fDND2wUWfqmPO4QnvkwcX7JC5/fvkQfee240
 TtHrjOBkMZZItWv6KTBP/bcfsWjZ/MCk2DCG+xPjpGOPXQRNNArR1/UCFuWVAf2LUUfZ
 T2oCUgUm9Rtoh4+h84BioL6HZQ/Sg/gSoieeXrHn6Uv3xpb8XUcL/m7C9/ebLuKKZdSY
 dZEg==
X-Gm-Message-State: APuU4Z+pD8+lIoFG+F4RMAF7EOsKXNoN9NCByew5+a0PRtTdd/QdJN1a
 trP709th3FbfcEbb2ALVRWVGClIyHIv4TQ2lTUehiHUPcs/YNxGHsB8UOu0X8ng2ZDU=
X-Gm-Gg: AYBFou1YnPN/WPjyLnJRqDewviXh7JYJCcX+p2vSbxSbUJ/BqybZ+YwFUoRhvPSi/U6
 y4zEn+CAIDqiLIbmNDnCfe9RPjCd1AjOX71oBKmy2iNbP8rEy0L5bj1WzP7VXDADT5BTSFq04qL
 FYA7yfBrTrxSowMwKcnCJzwAD/eUajXUlDFI+2PLJLHPOFd2EF15Bk99XrBvjvTGGhLaIP8nKoV
 jZqPbsd4bE6/PuqGcofjS3GzLwNtCWdt1jhYEpCs4vdsjqUEZwFR7aCRAFa7bjlsF9k8zuyg3bN
 w5erYI3IETsTgovH1Vo2bRFIcLG4Pd8ZOJ5/GgZlEwINgjXXjU8XGSnMblADcGYJDUPvC0wUgi3
 t53tbMBp3Kvamf4KpE5WHH4nBIln+0GivCI15e6s4Vy77aEuvq3oM7gsJQQqkJ7TTx7zZwJJASZ
 zVaLyYBJGEQkDl7UpFLlYogOV/Oa8itiMVR64P+1r0tnHDh3wMyuQCfLpyKC/JSOR4VUS/Ljhth
 Yi7o6/4v+mmp3gEDrn4LvBperwsWnV6tcDhFqNkO74cX8f3PscOj9+sVFFntjofZlmc6TTkDhGH
 p7r96S0QPJB9IjYrZCZvOAhyDwT3BA5nWA==
X-Received: by 2002:a5d:5f07:0:b0:48d:ef7d:4b4c with SMTP id
 ffacd0b85a97d-48e6e4f8c4dmr34647272f8f.44.1793789957735; 
 Wed, 04 Nov 2026 02:59:17 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:17 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 0/7] K3: wait for TIFS init before CTRL_MMR unlock
Date: Wed, 04 Nov 2026 11:58:18 +0100
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMsP62oC/53OzWoCMRQF4FeRrL2S3xmnq75H6SI/N06qTiQZg
 yLz7iYWSilu7O4eOJzv3kjGFDCTt9WNJCwhhzjVINcrYkc97RCCq5lwyjs6cAGlXcAoTHiZYY6
 nYEEfOw5jhozgwwXO0yHaPSRtEZjyTkupuOqR1NFTwlp5gB+f3zmfzRfauSmtMYY8x3R9fFRY6
 /0bLwwYCEqdM4NXBrfvRl8PwSTc2HgkzS/8R2CUdS8LHCjYXhslfD8YIZ8I4pcg6MuCqALXXS+
 2Eh1F/0dYluUOSoCHSsUBAAA=
X-Change-ID: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9dPPPbUUeMXV+0rmCcYX+57/BcibbdQsNmbiyD/kUVE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzX/PddeL+8F+1QezejzmTy5Mtm05+8Z1vuYhR8+du6r
 tc8N/3udkxkYRDjYrAUU2TpTAxN+y+/81jyomWbYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MAbqsXw//IXQfurLHP/Xu3Lnpa3H3JDTbBHCtnh6Q6nnSxLzE0koph+MMz6/P9ss8
 zmDaEfoyLYfrCWdoa8mHtpbIUwx0cB64mzGAFAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

this series uses a TIFS barrier before doing the ctrl_mmr_unlock(). This
specific implementation works for the platforms where TIFS is already
running at this point. Note that other K3 platforms may have the same
problem, but for these this implementation is not straight forward.

This series is only tested on am625 HS-SE. I don't have any other HS-SE
boards.

Best,
Markus

---
Changes in v4:
- Update SPL_DM_EVENT commit description
- Add a patch to separate EVENT and SPL_EVENT
- Link to v3: https://patch.msgid.link/20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com

Changes in v3:
- Added patche to add SPL_DM_EVENT
- Changed the patches to not wait for TIFS and unlock after
  spl_early_init() but instead at EVT_DM_POST_INIT_F.
- Link to v2: https://patch.msgid.link/20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com

Changes in v2:
- Create a common helper k3_sysfw_wait_ready() to make the purpose of
  the get_ti_sci_handle() clear.
- Extend the series to the other SoCs with the same boot process: am62a7,
  am62p5 and j722s.
- Link to v1: https://patch.msgid.link/20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Daniel Schultz <d.schultz@phytec.de>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Paresh Bhagat <p-bhagat@ti.com>
Cc: Julien Panis <jpanis@baylibre.com>
Cc: Jacob Parker <jparker@basepowercompany.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

---
Markus Schneider-Pargmann (7):
      event: Split EVENT and SPL_EVENT sections
      arm: mach-k3: common: add helper to wait for TIFS initialization
      dm: core: Add SPL_DM_EVENT
      arm: mach-k3: am625: Wait for TIFS initialization
      arm: mach-k3: am62a7: Wait for TIFS initialization
      arm: mach-k3: am62p5: Wait for TIFS initialization
      arm: mach-k3: j722s: Wait for TIFS initialization

 arch/arm/mach-k3/Kconfig              |  4 ++++
 arch/arm/mach-k3/am62ax/am62a7_init.c | 17 +++++++++++++++--
 arch/arm/mach-k3/am62px/am62p5_init.c | 17 +++++++++++++++--
 arch/arm/mach-k3/am62x/am625_init.c   | 17 +++++++++++++++--
 arch/arm/mach-k3/common.c             | 10 ++++++++++
 arch/arm/mach-k3/common.h             |  1 +
 arch/arm/mach-k3/j722s/j722s_init.c   | 17 +++++++++++++++--
 common/Kconfig                        |  8 ++++++--
 drivers/core/Kconfig                  | 10 ++++++++++
 9 files changed, 91 insertions(+), 10 deletions(-)
---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
change-id: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e

Best regards,
--  
Markus Schneider-Pargmann <msp@baylibre.com>

