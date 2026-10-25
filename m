Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81227606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zaXNhE3x;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dRvGaLyN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 412C980937;
	Sun, 25 Oct 2026 19:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9yWmdx47wgTP; Sun, 25 Oct 2026 19:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 568C0808D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792956670;
	b=i1tV9Gu6NYNWfbOCqIdxxw17OJbseAlvVkn40Yo4qy2GRVFzfkZkaL8dkzvgrOe/F61J
	 fc9ONo1M4IYZhye3fh9LFxOYLy8trqQHDXd1bYAPbR2mwNS40JH5i1VQ23pjoNaT03UcL
	 8PHxZM1BbETwd6LB+2rQc5tLpyu9LS/A226J/dM40QYo3CzzhaQ6T2d+DDoBW75j7XLeE
	 aGyTNit0WdMn8ZQMNEj59It/qMqba1lEI7KAYUcd3EnlF78mlYahnSpLoAwO8S9Wo/SAI
	 A4HcGqR4AtpNWf9edfuLTi9Ek1GLB9UNlZ49LLZd6gb3g64wOTEwwN2uLhZP9WSDXwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792956670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HnSNtI67iHtLgBdB7oMMb9Z8U5fGfuNwg5rfy241J9E=;
	b=cHKZtt/zDoFNgb4Q2T1vAE2CrzfBJGCdn6a1XTDtqAGEeKv5MPZ/Ep7rSAMTK2yAGJaf
	 9zffD4LV6MuGeUXsCoXQz3jY+/1DCXo2BHnbhWjn2Q4gCqEjAx94xy5mfxrEgAplOuIGm
	 g83LOX6/rKydkuf47QVZA1O4DFOAOCcWTgp/uemNsTDpxqZuaQNBhazwku3dN9gXRUZy2
	 +aa3jeCPdKuIS2NLShS3qa5ChiRDQjUxIKbM4S/hEC39ifDp/s8YiCb8pAsh8Jw1KdGqm
	 7UhyFR/Wbr+3H6zpVuWLmiCy0ML+joU+MqDfxjQRcGnfqHC4J44lpzPFlfGpkpHhGoQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792956670;
	bh=HnSNtI67iHtLgBdB7oMMb9Z8U5fGfuNwg5rfy241J9E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zaXNhE3xxBQq1cd3DJIwau+qEag6imjiZnyEUnoiarwegaX0qPcy21Yooczc6tb10
	 aidCYGCt2+eHDg6thYs0tzh9E3w50z9oOPIYh0/hl3guc+grY6eJGMHL5wTVqa69nF
	 Wheew2DI3OKDsDlK/b9G0Cri+meuCYRgkNvFeYv71LqKsD43dCNiVxHclY4xzl1YzF
	 daK0RsiCDr9/k6wpM9goN6fjJnla3ca/nSh7BWhD3gg0OrFlqApgbLRixv2ZyM7wDJ
	 EFa3Dz4O/7ZshIQwhUGkgeeWSqN5H/EOHnBReYnUUm6TguGPzlR4ebmbCh2J8msOP7
	 xE/mg2AJRwC6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 568C0808D9;
	Sun, 25 Oct 2026 19:31:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8D044D1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEFF460601
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3x-O9gm3ht5v for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 19:31:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B44760600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792956668;
 b=mTvI/gvhgDslGKkz28hGDtSwQzABX/OhtVMRDd8aNg1v2dYuEsj+Kx5NXrCle8U4NsTG
 KRof4keAiWJ3qOxUXZh2R8l6+UI9gkwoG+RRoI4Op4Vw2gkxIaR4A9RPmc/4cgTC38eIE
 15MUAJpux3yBx/oYNlRAqynnILx1dDf4kW7PVqFGg5omYlrUVNjfGNYCrZqRYaxSLND4n
 198EiX+UPvu/LP0u0vbtoyRHmJdJ8M5Wan3lhsvZY3Q3NT9C0wJxjP6HKD0O0qIgiDC4G
 pVbjFP29dTdWebmibw7qja6TvR+A6SXZX4HJqLhANP8te7oZhpbtipx8e68BB4e/4rQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792956668;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=HnSNtI67iHtLgBdB7oMMb9Z8U5fGfuNwg5rfy241J9E=;
 b=b395iCNng1hophDkEYmP/SH+9UnXYXK465MGEXXVV4C2sa/onURPUmfhC/+FdBuv/oPP
 pFHEeynIyAQ2pDdLXiW9lr4TFuXJocjPUDCBUupXpPJVaBLExPFMSfBfP2lAXaTVjIWeR
 w0O1fL/0jciDYaXfWKXUYEdbVYKFp5WB1h1qjHbSMNxftpwiJEkNNQQBJ8nZFJubvhcLF
 wDhz7bxnZPQWQ3/J66nmOaM3Rnlm8K1fn1mabzfhx45GwAJ1HXdilxks1STcNoyT76azD
 CGMEgHtcaQnmlKf8Xwo0vG7yeDFwFmciHoYLI0nUmJPnD6XtZSH26t+kDf2b43iJCHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dRvGaLyN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dRvGaLyN
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B44760600
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:08 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so15870115e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956666; x=1793561466;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HnSNtI67iHtLgBdB7oMMb9Z8U5fGfuNwg5rfy241J9E=;
 b=dRvGaLyNK7lKrUfQuCu+TM0xYuIPQHhsa0W0QTOJVMwCyfo0TEKi0D/ewQtF8eQ9xF
 WhHtpq48vd7KthNyqp13awqh1Gvm/OV9AJOcvKmHYlGROD0tQWQW29Te0gmGXBq1tD8D
 BTfzO4d0cRLc3eONsFZ2yt0IMNykFxmfgauqgrUdF9IUYb/JfyXcqjbG6B+durMkYNHw
 qRChzuMCVrjld93MmpI8/6+YUKqEP0tUzDduXLekYekz7JVcLGOfxGqN12TOfYd8zjJb
 3113Ze4zxH31OkbZljUzPu4dOPwJjaeDhrRySbAUGIagMlIlg9gJrCMEv/45ez90EHw0
 4kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956666; x=1793561466;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HnSNtI67iHtLgBdB7oMMb9Z8U5fGfuNwg5rfy241J9E=;
 b=F8Jvz/0uF4/cJkNSyRPzfM9MNBAyoKaMnA/KIonwKn3iQxqh3Vm7UNgzt4vIe0eT9D
 ypTBYddAS5oA6wZEcf2sJ+B8kUFFn/6qzqn8Zmjott1zuUHLR6QF0TmYD3rett1RHDFn
 /Fl7XfX1mILe+654tA9NFgUIa5mbEG/qEOkVQ4sbEwlVaJfdO+6umkKQb1yZfJ2nTxK4
 yh3glPRKf5IaYhxZQOpa9HBOghtTYXxF9bKKI4Uzd50p6oi+AQWRYaNR+vxMjfIcBFMC
 lpbVsSS/U8VzfORy6TTUcb3dAURNilsARmk0n6igUIeqbjrAnjOJGMGExF0tzt/9LHQZ
 keOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBznusyjEYkLZM0Gu2RDnBReZPzbp54nS4sh+LgjCynZ3cm+tq7jpbKufg7rv3zMYdFB2Yt6LDo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIsA8FC2PUGxfkuqI15f7GndQ9zCG6a2j4btey9Y6Pe84hrDkUz
 CkIujHf82KoecGOvqi5Y6Dl9ciQ6cyRvovDqxK5aIn3dlrDNzGpWRzqQGn2xEw==
X-Gm-Gg: AYBFou0gBjXkVg7qR9ryRjn0ChmCYYJ9zLNLqob4qEXVdrSMvau5Kc3sYYjG8+Vpta0
 1jUFxm4Vc7wygpe92kSAwgtxjqCWvHk2+hc9qK4fVUqie24kCMB6KGpv4g52pQz9FzaiP4aOzM3
 eOTj1kby34fNDDRqS9+umnvmb2lu22yyWqUnaCN5PhxACly4zOLd0ObVyRzsmTIiXTNnlDeOsTF
 EqtW9kDUb4EcWOlZ+iujZRfQMNlPClSX3e5FD9/+3nyPYOTtbVDbZeNAUZkQVVZaKfwO2MwjVd8
 qX1D4p0mcXBjyGyvbmEZNdZmsBNN7J9sfv+sDrbqesiUGv+C4ndExawDOxAMS7qmxu7TyvpIOiH
 q+crUe36ZuPRyTUB2EpMV28tJELrsSs67diSzY+XzHuKzRrrOLD+3Bjdus0jTJQyD3XJRGH8Sk9
 kobDa9RO2fiEumTWiYrsJ7/GxZLERiL1eLx8PaoKj8OLPhAYQpuja68MeI1o7r26uZoOiH1OMoV
 2b8fZ16/UHHz02VDXzEglLAMdgy5tkDxoSZE/uges2Ky2YjgDkMzk5A1/rNM4twEzU=
X-Received: by 2002:a05:600c:870f:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4a35ac9d1cdmr80986895e9.17.1792956666333; 
 Sun, 25 Oct 2026 12:31:06 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.254.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm176549365e9.4.2026.10.25.12.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:31:05 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2 0/4] Support multiple SDRAM configs in PX30 TPL
Date: Sun, 25 Oct 2026 20:30:47 +0100
Message-Id: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOdY3moC/02NywqDMBAAf0X23JQYg6Y99T+KB7tZdYsvEg0tk
 n+vWgo9DgwzK3hyTB6uyQqOAnsehw3UKQFsq6EhwXZjUFLl0igjrHWiX7qZhUJd21xnWqOBzZ8
 c1fw6Wvfyy355PAnnPbAbLft5dO9jFtLd+3Uvf92QCilQYmGyoiKr5K3pK+7OOPZQxhg/JsHK5
 rQAAAA=
X-Change-ID: 20260828-ddr-multi-2c4fd64344c8
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TPL max size for Rockchip PX30 SoC is very low, but 10240 bytes are
enough to store in two SDRAM configuration parameters sets if option
CONFIG_RAM_ROCKCHIP_DEBUG is deselected.

The approach is trivial: apply the supported SDRAM config sets in
alphabetical order (DDR3, DDR4, LPDDR2, LPDDR3) stopping at the first
one that makes SDRAM initialization function to complete with success.
The chosen order is debatable and not based on any specific reason.
If a smarter cleverer or more reliable approach exists, suggestions
are welcome.

The patches have been tested on two boards, one equipped with DDR3 and
the other with DDR4. All possible sets selections have been tested,
even with orders different from predefined one (e.g.: LPDDR2, DDR4,
LPDDR3, DDR3). It would be useful if further tests will be run on other
PX30 based boards.

The first patch improves clarity of SDRAM type support selection for
Rockchip SoCs at Kconfig level. Not all the SDRAM type config options
named in the Kconfig are supported by each of the Rockchip SoCs. And
no more than one SDRAM type is supported at a time by current PX30 and
RV1126 drivers.

The third patch slightly optimizes space of sdram driver debugging
code, and the fourth add a new configuration option to allow limited
debugging code to coexist with multiple SDRAM types support in the
constrained PX30 TPL.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- Update and reword cover letter.
- Do not duplicate config options based on SoC.
- Add SDRAM config option for DDR3 explicit selection.
- Raise compile time error if no SDRAM type is selected.
- Raise compile time error if more than one type is selected but the
  driver does not support more than one at a time.
- Change order to alphabetical one, as the most trivial option.
- Slightly optimize sdram driver debugging code.
- Add config option for size-constrained driver debugging.
- Link to v1: https://patch.msgid.link/20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com

To: Simon Glass <sjg@chromium.org>
To: u-boot@lists.u-boot-project.org
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

---
Massimo Pegorer (4):
      ram: rockchip: improve sdram type configs selection
      ram: rockchip: px30: allow multiple SDRAM types selection
      ram: rockchip: reduce debugging code size
      ram: rockchip: add config option for tinier debug

 drivers/ram/rockchip/Kconfig        |  35 ++++++++++---
 drivers/ram/rockchip/sdram_common.c | 101 ++++++++++++++++--------------------
 drivers/ram/rockchip/sdram_px30.c   |  39 ++++++++------
 drivers/ram/rockchip/sdram_rv1126.c |  54 +++++++++++--------
 4 files changed, 125 insertions(+), 104 deletions(-)
---
base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
change-id: 20260828-ddr-multi-2c4fd64344c8

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

