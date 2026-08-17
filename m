Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927DCC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BE584086C;
	Mon, 17 Aug 2026 18:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7dQ1LDUYJwF; Mon, 17 Aug 2026 18:17:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FD7A40869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990646;
	bh=kCIFlfBQ4qcYVxTjUHXCXmdkk+hDhU/r6JNSGGTwTEA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A4Qhx4NOwYAIELhsdtSkiS2BVRhDYLEaRWT8bTA18cCiGxZLPNCw8VQciAhk+n8d1
	 FWADN85oYj+JloT3EQ9oJ3wY8d+msNrN8UqTmTTuv1wxJk5pLmXPUlegCKe9in/8Mf
	 NvnKWsFor7RVUAN9nCx7I71N/0iG4Jv1awDKkDTvY0szzOYY+aZt3fW70g39+TTGdq
	 q3cuIAdcLPUsd7WP01p4jX7nBxSczuASHJWcJoQW7BT/oaGftVg9hzAO0iaZ0BCARJ
	 wTHobR3nfkAtv4MDWT5IIJae+GMq4iRz2KoiaeXoT3oIImNFbpJpCCZ0zKy8vgQkSy
	 YFkJf2tewebJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FD7A40869;
	Mon, 17 Aug 2026 18:17:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5C08333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97B6C80CF0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ypHJ8XuCz-7 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:34:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DB96F80CE9
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB96F80CE9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=TDO6Syyv
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB96F80CE9
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:34:45 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-934944f2d22so193959885a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786984485; x=1787589285;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kCIFlfBQ4qcYVxTjUHXCXmdkk+hDhU/r6JNSGGTwTEA=;
 b=TDO6Syyv/RULsNpI+LzvmMll/GNGTEakVz+BpjvZ60PBn4044C6GsWzL/2C7PvCaDO
 Ow/UZKkQQYC+KUIjv7Zg+Lf19GF2FamBnVChiqXxmV2y3tsPyw9yDQOsiET+4rY/9bxL
 WVnkhwgf+tPic4uKEEIyHREOPZk9xwB1Ub774foxR+xrfngc3c0Pz+3VhN0draR3uJfy
 CRN6ZEsMwMHidHyr6+Gt861B05sbdl+jcMEb8tDeaYIrev8g0BUlmGKIw586lNbb4eFM
 yd/0FYKSgdlK80BPwR/evD7ywkDC5/9DHYkerClSpqqUXlNCk+Dyp1GX/lqVbPSm7yN2
 bezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984485; x=1787589285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kCIFlfBQ4qcYVxTjUHXCXmdkk+hDhU/r6JNSGGTwTEA=;
 b=apoWiI4Y0VULWN5fNp0QJr1UIVcpxA4QO5+jvsre2alH0dHaPABwHb1x1fHg1GIIo2
 2YmWMg2SJZrIunMuTxqWurS0NZra4RwvrsdT6OyM5cY7OanjdB2c38NF/owlaPGkoQrN
 nzW5CoY9q0t8OeL9EbpuGPz9kWzqypg0XsYGmU4qXgpJJtml0lZANoo7VWgCMf8jzYgQ
 Q5CsrBsqS5+J7p0Gq3lIAET7ZIgFTLQFIecVfiQGasktaaMBOs089FwPo6P6fbhRjRs+
 LqY8chcCjqGcKEUYgPvMnYdG8Kz6P4/BvS5EoGY8X5ttFx8EwyJDY1rbl2g4AGFiS1Z7
 ZDCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZPEdmdS5exhxNiwzfiEuEQxWmmbq8MqE9zxob757zw7dMPSgpbatcy09LXwKZBNk5IydhZAM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyF06HEvE1Y6Yd/J2FP/FCMJ8aVcLd1S0hR64G4gzo1MdPt4XM1
 dREMK/F+/p9PQHWBfW/ExqcPBpOZ1B1ifrxJ/IRoWG2fAMW5WmGcJLfsiIm362RhcZ8+iJDEwQB
 mkIAffwUV590Sf/qKkTsdEs34WUWPFwyNGCQpg3Ioriw3D3Uy1ztUUDSv2HXw2hpkvfHCKUbWW0
 ScSfU=
X-Gm-Gg: AR+sD13/8AMFS1E0tUruQP94J0vuKrh08dnTdLbWoM2qo/0/VXvY8Il8Bw8N9KX7GGx
 894bQaHfBGW9JW+/4Evv4bGDsqCFFDTpnr3GJ6heXEwFq15E8SHnumStGViTQr7MicOav/MO1Ik
 k9ZSaw5D+PJB9I2lG1cx/nUZZz7J04h4U/8eq6CcWLz0NxdpfVYPqa6F3fulS5f6XS5DW6SFAj+
 IsK4+iEj0GPj/jFvDe/BJ9QCZKdNZA76wKuUTYyO7FmY6iOfi1Aa7oSNbdmrNk8hPFt2HWlxZ3F
 owQfDJMhWhWsXVAB+7UsXZLtPBdmx9LpQqzkThRnKu3IPCj1/vcT/ejCathA6NJY9CIpnks7wSq
 TkuZlCEnijBisrAkk/k/Nq7QNDhn4Q7Go1IT2802BEbmG4AMzDaVKM2PN4S20Fk/Oq0HEbEq/7C
 nMUCGK3Z50uon03G3cpaHDAvrQKD1Mn6p+CKmIYODdXA9Gx61g+blksp++O+VCeLvYTQFhbTZwu
 I3/WbW9oKaOGJovDL3EXw8aKgo=
X-Received: by 2002:a05:620a:4143:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93704b12d66mr197540185a.12.1786984484574; 
 Mon, 17 Aug 2026 09:34:44 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937033ce78csm83874085a.31.2026.08.17.09.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:34:44 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH] serial: meson: Add s4 support
Date: Mon, 17 Aug 2026 12:34:36 -0400
Message-ID: <20260817163438.1893025-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

No new features, just a different compatible.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/serial/serial_meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index cc71381f87e..336ca552ead 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -244,6 +244,7 @@ static const struct udevice_id meson_serial_ids[] = {
 	{ .compatible = "amlogic,meson-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
 	{ .compatible = "amlogic,meson-a1-uart" },
+	{ .compatible = "amlogic,meson-s4-uart" },
 	{ }
 };
 
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_serial

-- 
2.53.0

