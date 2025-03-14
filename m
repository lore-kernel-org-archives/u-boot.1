Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1F5C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 06:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E772817D8;
	Fri, 14 Mar 2025 07:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZtJW3fc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9268197F; Fri, 14 Mar 2025 07:47:44 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE6281760
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so8162566b.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741934860; x=1742539660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cuEwG6PyTMR86MFDYDcB/C8dhpjH0nrz8h68sr2qhWc=;
 b=jZtJW3fcoj6SyxfU114wTlo9bpH09a4uT5RZMCerS0+E//2NvZNOtyQN+Z05cpr8nD
 wHszeUpdUysP3HBpaz6hN0c7QsPw4RftTSpPCr6ckIL387jhHmJuD55ftnX8Js98cosm
 8SFUurGp6T5Jt3uZgYeiQX5VgIgF5KDGpOaGXoGmO1ciTvWnGUhoQ6PD2fS2S+kV628p
 enQFSYmHAzEllcHoO1jW2z/mqu78dFGT8aDO57qh/zKlpNDmsKkpn+IBKzXlIuaEqBCP
 dbSfmlmZy0MOeYhkk28WU95GGOppkB/ntFYcsYPilL4x+J9dDc/2ShaxwPWP46UfIT7W
 9VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741934860; x=1742539660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cuEwG6PyTMR86MFDYDcB/C8dhpjH0nrz8h68sr2qhWc=;
 b=JGJWba6A4W0Ug47aoNW4HOXXsNW81pgcTu5Jn2wlsoy9njTSebVuHp+VZkal+/uGtj
 UCzBz+lOv4N5p52QHQC8wgiqevxYucuSQKDGxppl72pB3ZS7FE4X5tMqOsasT/Qwr1UN
 A7808kGRp/RS6/IuOSDDqjLQyJ7kXaRDU9BcMjz3oI/wqHFyt+MlXrBsi8ZvGmP5nV6Z
 jgL+58vWA5bQsWMZiqVBR25SAN+LUMpCJAZ+PUu37qwIV+adWmQuYwrZpVXda2LKaYXm
 uigwoRvlMlUtLsK1XjH/+pk+F7P727ls6LAnIFDyQGe4wy8P1dVEm99cuPsxaUW8wcy8
 V3rQ==
X-Gm-Message-State: AOJu0YzKDE7uBvCAsaSvlK2vQHOppSmnw2iDB6sY1J/GZKVq/NnF6RYE
 VQcVc2s/+APoSOixEgf65uNx9hyoZYXEd3KPwI0HadjxU+kX+OAS
X-Gm-Gg: ASbGnctctECGWDgHXHOsjLz+Iet7nx2shUJ3r+O09+dHK1hsNjIPy/3sSIivPF/uAIC
 vtlRXSWcwU4fXaPBjtXAg+vlqB23zfVAAoXTJ1DztRgQSSWKaVWTjRrrpFndLUMQ/E1Ys+jsF4x
 6L1+2uObP19mjUi38Pd/oDaFxsh0V4fWRhy2oOuqgXzHNQY2OBJrU5npSEHAmJSDX2oc8OLWxkR
 Nht9V4AtLxIWMApbpv/NhIeSpqT8SqnoSMWpcDAKRNVoze61+AaKLwrGDiPTGY2qO86gJpwlvLh
 0ZErQAYBv5QPDQz2iOrfmjtL2HeVhg4MXlqz
X-Google-Smtp-Source: AGHT+IGep5nnVfp+nyr9a8Spzowt1cLyPORYX0T9WX2Gia6J5np+J4R9EwCD4a6HcM45/FWrWjlqQg==
X-Received: by 2002:a17:907:9694:b0:ac3:131c:fd0d with SMTP id
 a640c23a62f3a-ac3303bcd03mr151255466b.39.1741934859895; 
 Thu, 13 Mar 2025 23:47:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a49c37sm179471766b.158.2025.03.13.23.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 23:47:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] video: edid: guard standard timings EDID expansion
 behind kconfig
Date: Fri, 14 Mar 2025 08:47:19 +0200
Message-ID: <20250314064720.5767-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Since EDID only indicates supported standard timings, a large table with
detailed timing information is necessary, consuming significant space. To
mitigate this, the table is made configurable via kconfig, allowing it to
be excluded when not needed.

Svyatoslav Ryhel (1):
  video: edid: guard standard timings EDID expansion behind kconfig

 common/edid.c         | 6 ++++++
 drivers/video/Kconfig | 6 ++++++
 2 files changed, 12 insertions(+)

-- 
2.43.0

