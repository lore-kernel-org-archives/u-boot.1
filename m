Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF521D37E40
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CEF8063E;
	Wed, 14 Jan 2026 16:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tEwLGotl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40DF835B3; Wed, 14 Jan 2026 16:12:18 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C36880325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso59899235e9.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768403536; x=1769008336; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qpDNdkEgK+TEKihaVBZ/Ee7WFJl7XzR2o/7gvcp4FXA=;
 b=tEwLGotlA6hWIM57T847BsTDrl/qn9EJmaYVBwNGfY/FHyhWXSag7NW30Bxxu3G6e+
 ZqNrmUi3YguiVVZ6reaDJD4EYedZY/wAuf4tknIPrThykLduKtu1+RRKVRFfsVZKUETW
 yBLG66Yv1riiqaxt+oo1ZOHpsbPG+LG16x/ITGqhSdWN2teLxkEwY+MXMvfOC0Wig2U9
 tx4LFSxJQ4ZTAUJnrLvRg+czxc1bwQ+qbefHciuOEN2WZVfKxccNyBK2a4kKGurpNQt0
 aTrFnNyqJCPqjzZIrsOeB0K7EakUMyAbDBYYxW93EFh7UwFamqU1ud/rOJ+xOosBaINc
 exBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768403536; x=1769008336;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpDNdkEgK+TEKihaVBZ/Ee7WFJl7XzR2o/7gvcp4FXA=;
 b=RJ4i+hUJf76FY3orAtgujf84pKAHdAFdAjppfvxzXJbp1dzJ8e37RzpT0Q6nlEphyn
 KiPdEDA1VgGWlfntZisT1RrnSC38Ty9ppTU//9xHbrRVNGsK2qtqiyKXj34Lwa+u1j1f
 cBZHLQEICSWY3/UWDUgQ07vk6V7yaXcCe620dEK/k/ox5BzpQ9KkkrjWHGHKJj8agHMr
 817dVuSlVGjXM1pMwr0bteEe1n2wtItynhtsAQ1yeNFEQn7mSD88pIDHPeytUuDO7Hyh
 w0cv+VqlFwPzEgMBuaesuplB6kciTyWMA4oNtJVNqJ4rogDvnOziuGb4x9gEUm0Q97UO
 I0WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAJjaDH/X50prYfYBfMP24aw6YhdeYM07GXDCDpb7kx0dTGeDLTeijR+H9aGFcZwci4fx25qU=@lists.denx.de
X-Gm-Message-State: AOJu0YxPMVgosgowV572J41Kn4v+Dni/y2eH1VAYPExqOPNmn9O/11ly
 kZFY/FDkc1+IJ0VgG8rmyu/TvCui41KZoh4K40Rgw9OO9dkEslT7oyBDfiiC1X8a+tY=
X-Gm-Gg: AY/fxX4F/oUIdxMTxwKNi+PMWtFJ0oujeqPSK3RRKEYBpWBoeHQDo4dM5iIgyvttDaU
 f0iR7NFr3XvvEpcrXK9JNOYIVIaQGu5epU8X+Ntlgxfmup+vtWoJkyUgWXNGMMAWx0+Pt/Z2uOs
 L5f2wjglESebjdkOLGQo/Ku3+k9VviYwVUREBQOyB2q2g8Iy8TQn/N6ajbLuzqWEvnWkvewdNKq
 QKJ/a24yWQ+uR+wtnh9JFpvBaTSyM0S7s0MPZebCh2OFITpiEES36GqJFQ/54ROl1XKbDikyi2y
 cStpru1OHniGKa2AwfTgXJeVhg1vfL5hhDKNAN+0q6W4HryuPPtXq0BwmBGVkexSC7w82ObHyKO
 dyAxV7UBg2knehXiYImbhnFSes2Fg+jSviK488lNkrMZf39fUGNR7+xdY0LoAe0L+XP4xvU3pWj
 2PLLDz4ZTguzA2EaSVNQg2CTzeGQXXjYyfRmFK8kuISpULtZeN5g==
X-Received: by 2002:a05:600c:4f0b:b0:477:9392:8557 with SMTP id
 5b1f17b1804b1-47ee4819824mr27851065e9.18.1768403536073; 
 Wed, 14 Jan 2026 07:12:16 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:2d90:e4f1:d19d:4c32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm50455212f8f.5.2026.01.14.07.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:12:15 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/2] net: lwip: Do not write past end of buffer
Date: Wed, 14 Jan 2026 15:12:08 +0000
Message-Id: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEiyZ2kC/22MQQrCMBAAv1L2bCSJGqkn/yFFNk3aLkhSNiEoJ
 X839uxxhmE2SJ7JJ7h1G7AvlCiGBvrQwbhgmL0g1xi01EYq2Ys85fU50Vuc0PbWGYMGHbR8Zd/
 0vnoMjRdKOfJnPxf1s38mRQklzNm6i0Q7XrW9vyggx2PkGYZa6xcjpGkzoQAAAA==
X-Change-ID: 20260109-tftp_fix-3ab9bd66a6ad
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Fix some cases where the trailing \0 written by sprintf is not allowed
for in the target buffer resulting in writing past the end of the
buffer.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Address review comments from Michal Simek
- Add a second patch to address some more instances of sprintf writing
  past the end of the target buffer found by code inspection while
  looking for an issue.
- Link to v1: https://lore.kernel.org/r/20260109-tftp_fix-v1-1-64bd50abc72b@linaro.org

---
Andrew Goodbody (2):
      net: lwip: tftp: Do not write past buffer end
      net: lwip: dhcp: Do not write past end of buffer

 lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
 net/lwip/dhcp.c                    | 6 +++---
 net/lwip/net-lwip.c                | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: c05dba22f1f2b0b2655ee3971644acf1936cd07a
change-id: 20260109-tftp_fix-3ab9bd66a6ad

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

