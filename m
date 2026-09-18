Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDF2C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BE19811D8;
	Fri, 18 Sep 2026 06:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8O0M8hFmFDA; Fri, 18 Sep 2026 06:36:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CFD4811D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713368;
	b=rZN6jjSFgdz9T5Y+9gRZYCTGb7Hr7u7MM6+cqH3A92opId4WFxBp+ijOk0XSLnf37C8m
	 lD3stjart06ZR7lfLl1liPzIm3z/8hCXNHjgL1h8VG4uVXAmdmscSniIs9xt747jCgpD9
	 dOxWv1Rqtu27Q2IlWz3To1REUNAVSC/NNsKhfjOfYs7oe0gzgcSOvzc8V6ySS28spR1Rt
	 C6GoUk1TGb9xciWgqemP6N7fUHgP5jKGCo03UJJ/CMssRRi2RvgTdmnxAtj3xViSGWISk
	 sJ+N7/+ngStavgIRq+qmr9EV1bDmwj/SOPn4MQ52UJeFAn52HgER7BLEva6A4TMNqqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wurQhUTWX4hHZHKBwcnxDJOJxY8cfBOaNhgw897oQ8c=;
	b=ChaYykbVdw0Hb07Qi0RecX3g2ekzCpGKRNjFDGT9CKMPJCLWDSCZrc+5wZvz/v1KKebp
	 ACpqa19HbNYIGvDXWzhdhxKTbPTHHE6+BIv64uzDHejETu+f4VFv7GbfSa3NRDfErHhvl
	 1S1bSjvGBoEIILPYwQxdt782J8wLh9nAer79u1Zbqea+ehA581DEkUPHd87NAaDL1hoT8
	 +AMMDwu+Gg45Cj1YpHxvHiXOmDeW9CJK46BfT6r5Pk5C/UsnudofvWO+r8j9T0MM9EQzn
	 ZRnsm0mKrjaF7zmMB4ZhVwmRLZ16I+6g7NDWlPEEd4OnmqtvNRY6YFlmJXamgVz+trg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713368;
	bh=wurQhUTWX4hHZHKBwcnxDJOJxY8cfBOaNhgw897oQ8c=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kpgw6JTwyoou+UjM0wWqKTg0dgRFAHIYsJhpJSp5LhQHx/vDRHtz1o1q8N9v3ElSO
	 RQJcIzoKMgiKld8ptY6bz+oHU1GUSh2yepJHOU6hM4Vc7SLypnLZcBuEQ7ozykDQFn
	 O+yHbLo5mAYH1onCuAA8Y58GOhEXYkwvfAK/EEOr4jp8vIv35toqdtDYNaMzJ0UT9d
	 rCoH6KCz57inmZacLTAF1ZWTbd5+4ZsU4HIyQkwZ6q6OAXe0nezUvsl6wCIwbxlCOJ
	 s3VYq03e8JD6Jj3i5h3i1mV5Pyr/UcETTorrV4aq93iYAW25jebRzU7ey1rJXhsU6B
	 0bDlYlyfT1qOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CFD4811D1;
	Fri, 18 Sep 2026 06:36:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0106D13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA2FC404CA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mq812ELIPo0X for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 88471400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713366;
 b=Q+a8rEfKmmmB2sFNIZ5JwkhZfdsFYVLlkkHBKpNx+mgSIatbjlkNYeHmi5Zs+NbRWmSj
 vVXjgwFRwNK7r7/CuKqIn1KFls71NkDTI83Psp4WjuJrbOXgfF8GIFtj+aRqbMkhhi1MA
 2Rl5ApK2Em0nmpoEaO/EgUlk3Lrwq24Et+AoWozU6Dy2rxZIqKk+VzUwE4H1Y8sUaY7bx
 7FWMt6IEqFl6nt08c4nDrLu81ImNJfTDrG1nuZNOkmvHebuHs7dW7qtMG9Y3CEyq2pvTs
 OnoB3NGCQc5GpU7/4X8rYbSmcvvNmd/NDu5OzosuIw0DHNarfbj+Ge+2/LPrfGU8fXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713366;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=wurQhUTWX4hHZHKBwcnxDJOJxY8cfBOaNhgw897oQ8c=;
 b=cVvnQUixAIUTtf07yGLkIiG2nwr7LMSmjSJ6eym7HO8r39xo7iiMth17BHPxmYwuyyNg
 3ArLRR/7Jnm0Z8uU37cM0f/klFQR6zu+ZGfbPGIwXvLN/ih0hEGKB8i/Md/okvtVIqaUZ
 c9r0aq9T5yQBhxHaKazumuqHgEsIstrJtBdjK2ie2xX9HWP5P5MjBkE1FVrFc9gfF8Xp8
 LZVXPl2ydjdoQmVezb8BJBgBvkrIneF5LWBN0dF6Yx/olcdwVCv9onJeQZyTUH8cqDwNt
 a5yjUy+tRQ0Y4CF/BPjQDASG0dYvsds5b6XhABexP3S5qH6N+qWAVnwt2GAGWYQJA7A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=aWz8KNZn; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=aWz8KNZn
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88471400CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:05 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so3043555e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713363; x=1790318163;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wurQhUTWX4hHZHKBwcnxDJOJxY8cfBOaNhgw897oQ8c=;
 b=aWz8KNZnWUf8hHMkdBHl1sCEbE5QICNYqTiNW/f3aHzb3wmggdLHsp48XBuXbJQHSx
 5TnFSjPhbKjk+aWqOTbD8p3t8iVWN0J36CV/5zOef1BjPT1004YoNuZOb63fbgYgXpzC
 f/B2j/pBhqIgTBACyT/XH6TYBdIHJuJEOYc7u5Hmxh46Wc+UyK8Ip+MJeaH8pD/cWjny
 2HAgmsUi1mqBGuYRdOZhZUGpwNmbGh/MnhG1ZB7KyTvNJkAp1k6s/zkyXMrZvYPUfT5A
 zynzuYrr4E9dc4hgCUwNmhTUrk+97iXlD+qK36gHbvr/jmxabTLlYG66yR3/P33BuO2P
 o4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713363; x=1790318163;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wurQhUTWX4hHZHKBwcnxDJOJxY8cfBOaNhgw897oQ8c=;
 b=gm/vvl6abOleZKN4QEUi2D4m1mfJ9i2nQxzWkmuWPe+JfvQNSwBCrBt/QDP3YeNixW
 zrXnUwXt9YyZ8Z0+Pfmpr6ChCZpX7MepYEcd1o1DO5JI3/EJvEhdToJZjCbLiFRFcUJI
 Xp2BE1ADiA69GAAebqoVYWYPpZKdd2eaV4KT35PWotJReaGCJnuhdFZ0YjWzDkur56pn
 zeeUpya6OIFnVoe8XujuA04Pg5JL8K333ScGVQ+qR5C+z1yvlWCuqRxAOXj+KBqrUour
 0cO+3c/P4/44a/zoUq3mynZ+JRuhYw+pPd7/wLMlltGZgx1NXwZ3cdaZ0p3PU+SnYoX9
 GKEQ==
X-Gm-Message-State: AFuF++mFb4bOsCWW2TrmxwXrJep9n9YHyWCbkM80NN8VMQKAMAwJfMBw
 uvlHlqVJGJy5NNjxYTsMAEaO+JVwKdtKK/YQ2p9yuI3DQXGgOpmrbfbuCZezt4Fp2ME=
X-Gm-Gg: AYBFou31/Dj/N+6R+DluIUbu8HR2YQB6tS/rZK2ng6ZLIODW5Yq05jasI3BSyBrMBNc
 4GYN4KRfzCaoAzR6qfKeUSIdwOScLyMcXycaU+J6L/JslPtqOq/kS30UJUS25B4YEvIoCYzpgOy
 Ou+kR06f1WMT1I0RTXrERp800Au+4ZTwMuajyOIg29M61F+73BjUXTNh+cXV7RdFnWhoEOn9mTK
 MeVwRQJJVHcp/EYqB3tui768N9Tqv342gEvIfM1zAXJl0DmDl8VOxfLhpSUKzI9VC/a5J2+GP/B
 RG1wCs+qkUw5mcF5rJHuuOOIZze9VMDjCclHSj29UwJ9S2KdJbpju8yHcMgsvbsPQh1GawFRRQ5
 /p0FjkaAWE3Gf2+dZKuglO8oqgy0cPbP/6AXKHx+vl3+hz8MSjzbNi3aqoRk/UaN+aS6kXqohj9
 lAp01K7Jm/CSshpZyUt1wtfzDiRFCCMGWhJQM3PfQ7xXmVwh8b33beTjOvMcd0SDoCaR6kASWiW
 pJKf5+rosMYJqqjZzZ4t1rnw07qKAlpMv3B8so++EFMmvpev0eXEjUBzmLcrA==
X-Received: by 2002:a05:600c:c8f:b0:49e:6c9b:4e94 with SMTP id
 5b1f17b1804b1-49fc5743124mr14868915e9.28.1789713362849; 
 Thu, 17 Sep 2026 23:36:02 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:02 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 00/10] spl: ufs: Add support for loading U-Boot from
 boot W-LU
Date: Fri, 18 Sep 2026 10:35:41 +0400
Message-Id: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr0Jm7Zi2ggmuvIdhAWUqYwhtOgU1h
 LsLGFcuX/L++zMIRSaBSzZDpImF/bCCOWRgu3q4E3K7MhhlzqpUJxydoIQeG+8TPvsRtbJkSOe
 N0wWssxDJ8WtP3qovy9g8yKatsxkdS/LxvX9OevN++fw/P2lUWJQ1Ua3PNm/p6noOgeJxoATVs
 iwfDQG+IMQAAAA=
X-Change-ID: 20260903-ufs-spl-boot-wlu-10ce2e14bf15
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4336; i=alchark@flipper.net;
 h=from:subject:message-id; bh=y9r5CMG8mutT8OW9EiN1ApDeulQN1Y5G95X9xWyRoTE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX2Ib7Ll5WCPXQv3mLjv7FS7wRHFankoUD9psaHt0
 d9pIQ+qOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqB48Y/lnb80yfo6Ecvm6Gt5XcW2aFI7W90rZ1H35ba/EVvH31zp6R4ZDkwv0
 RM34cTXOdvnvPnTuqpYrmBY0rzRxXLQlMX7b/AisA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

UFS devices have a built-in A/B boot mechanism implemented via the "boot
well known logical unit" (boot W-LU). This works by marking two of the
provisioned LUs with a flag in their unit configuration descriptor, and
setting the active boot LU in the whole device's attributes. The device
then exposes a special logical unit 0xb0 (the boot W-LU) which is
internally aliased to the currently active boot LU (if one is set). It
allows reading and writing directly through the 0xb0 LU, but doesn't
expose the LU geometry, so it is not quite a full-fledged block device.

Given that the normal use of this mechanism is for symmetric A/B boot,
real world scenarios will usually have both W-LU-A and W-LU-B provisioned
with identical geometry, so the geometry for the boot W-LU can be inferred
from the active boot LU, while its special 0xb0 LUN can still be used for
reads and writes to have the device itself abstract away the actual
request routing, even when the active boot LU is changed.

This series adds support for loading the U-Boot proper from the boot W-LU,
allowing to use the native A/B boot mechanism without the need to hardcode
the "real" LUN in the SPL configuration.

Two classes of prerequisites are handled by the first half of this series
before the enablement itself:
1. The SCSI core needs to learn to repeat inquiry requests when they
   return with a transitive non-zero status, such as the UNIT ATTENTION
   condition, which the W-LU returns when it's first talked to and which
   is not an error (patches 1-2)
2. The scan itself needs to learn to look beyond the normal LUN range when
   the implementation supports W-LUs, as they are numbered above 0x80, and
   "borrow" the geometry from the physical LU the W-LU is aliased to
   (patches 3-5)

Patches 6-10 are the enablement itself, split by logical parts.

CI passes all green:
https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1307

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Add a check for null wluns pointer (thanks Neil)
- Slightly reword the commit message on patch 1 (thanks Neil)
- Link to v1: https://patch.msgid.link/20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Denis Mukhin <dmukhin@ford.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Johan Jonker <jbx6244@gmail.com>

---
Alexey Charkov (10):
      ufs: hand sense data to the SCSI layer
      scsi: repeat an INQUIRY that a unit attention interrupted
      scsi: size a well known unit from the unit it stands in for
      scsi: allow a controller to declare well known logical units
      scsi: add a lookup by target and LUN
      part: name the well known logical unit device type
      ufs: define the well known logical unit ids
      ufs: report the logical unit the boot W-LU presents
      ufs: expose the boot logical unit as a block device
      spl: ufs: allow loading U-Boot from the boot logical unit

 common/spl/Kconfig         |  30 +++++++++++++-
 common/spl/spl_ufs.c       |  18 ++++++--
 disk/part.c                |   3 ++
 drivers/scsi/scsi-uclass.c |  32 ++++++++++++++
 drivers/scsi/scsi.c        | 101 +++++++++++++++++++++++++++++++++++++++------
 drivers/ufs/ufs-uclass.c   |  76 +++++++++++++++++++++++++++++++++-
 drivers/ufs/ufs.h          |  28 +++++++++++++
 include/part.h             |   1 +
 include/scsi.h             |  45 ++++++++++++++++++++
 include/ufs.h              |   8 ++++
 10 files changed, 324 insertions(+), 18 deletions(-)
---
base-commit: 37bbe6e3ed205037fbca390f239eff9899639e39
change-id: 20260903-ufs-spl-boot-wlu-10ce2e14bf15

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

