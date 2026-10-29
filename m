Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B3606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x2V6t3jC;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=daulpM39
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEF1D40A89;
	Thu, 29 Oct 2026 22:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tcBLs6gouhcU; Thu, 29 Oct 2026 22:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 635C540A8E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312170;
	b=rbuQS7KdEgWflFXqGvRj7K9VUDduXXUWv1vDZ5zIQ6j3pSl8ulAI1aJzJUlF3z6l+uHo
	 YoPIrXL+x/zteft4LyYZIFJIhKz761B35sis+VedOTJ7L1NiVeFuOKDNCGbNh9peLzoo8
	 MCn0I1s7s9k7vkulHyKAqEGONn1lbb34MzPZ2oY/lCJr2P6utMXE2Rr+J7373y2A8LD0s
	 Xfb2C4bQD2zn99wenTP5IB3R6yxa/fLYiF/1HZTAmljlvPIGG2M/cfM2tjaeH9/FqtyGZ
	 2bXV9O4AqzrOT1MagpYdAYMLygPyEqQjIwgKy+AqTyD3opCPYST2CHrHPZH3EjMAVvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rimlw/d7nzZ4dC/7A0zgSWS8+swT7gQjGuQHOdP50eA=;
	b=LLNy2aDhOryZpDe0BoHpX4uTlmoi6zkDCkCS/2hqmTQVIUH82hSEYhwLoRAPha+xsXhc
	 CeLLg5W5vlx6PU3EO6HULNpe1FJuNah2B7XR7OqXthQZ+LhcWbXmoku8OcwjQYUTYEW04
	 DgwV6WmutnA3q4lUnx2aoolzVriG8KfJJ+6+/fMldz6DqSrWgQKqMckj3t1iAJHtVA0KD
	 dPigcEbCug6V1gp2j4UIGY6LAAoDTyrp6Hzwl73pWETPbMzIrtuLpEaSquPgCg+C7bGSQ
	 OwwGgq1cuG5rkX7BwRr6XUAYzBYF4DQk9uLS5fRDnxSBNmvHRiv9DoPR7hCYXjNyULQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312169;
	bh=rimlw/d7nzZ4dC/7A0zgSWS8+swT7gQjGuQHOdP50eA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x2V6t3jCIH3yItE9HvCXjpMWOQlld+yAjZDYfQcrHGjsxtwpv93c9jxSEJbzEWbaM
	 xT31hTRsx3e8u1zh/XAbYcEMvZKPy+rUwNNN3ectuUPMsddb7pybFLJBDtTJ8M8c4v
	 J2TDePbGDcPO0nD0TAC7j7hP/B6zW7g6PR+NVRUCzqEGp7Nnhra1VPcKj+EQ9mnYWx
	 /4O1z8hj3le+9wFvLC5cIrJSumfHAVJW7FdP7Cr33XuknE+TPT5WjRMLlbxwh/0MCk
	 gLrJG9t3noP5ChTsUOPnF4kr8/kyxYovLoGvwguBwlHGWhIuKKBW9wIN3oIb81ZVyt
	 ogRB86DGB2uDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 635C540A8E;
	Thu, 29 Oct 2026 22:16:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D2F712
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A33FF40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0HtX1MDKalnv for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A2F3B40276
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312163;
 b=M7R5xAEgunSsQG7+UZ9iTndEB9FiAOre7Vhbc34ZdRoX3jA2IQnxOX6jXLMz9U3PGi2W
 G/0KamES3+MJ1t7+/lzCOjHh1zSXmispdcWxgoHjOcZ6Fdal85nqOtq5JiK2iXGLOL/n8
 Q8AuWq2/ZoJp7G1xzEYxF+uTwuANZTY8vhFjeQaLg3x4BffhbvKq2Dd/8XjO6AKkPh/La
 yCFzzyLquWVQnSs5ACSTa4yq/q1pMRCNI+U4WnmhseHok1G+n+lXAEZTqJcgK5gscwlKw
 vo0Vq6jdLzdw9hOHzcfY3X2VqZUasJoc4ZJKU9eDM08JgM5UXwbgwPzWGszYPWRSytw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312163;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=rimlw/d7nzZ4dC/7A0zgSWS8+swT7gQjGuQHOdP50eA=;
 b=S/uuwfFnBD46aQuNTEUn9BonK5v+U9GcZAvux6SbMAqTzhCqNVQnnDPdEFJGT41glhO7
 hfTSmacbNfcH24Swq50vWIvK/wHqmfGxiPhouzeb+pEnVEjxicBfhhcqs7T35VRDeuxWq
 L/vC1bPc0fIP1xILtWftIGuObMjQM6u0/edB8DZwfg0Qit3Q5n/KFmkaDLqV3ggXpAT0z
 F3IBDQdU/TrK/Tp6RntWvVZhX4B9T/G5axVSkGdXSop/xJjPDPuk9uXVn55yoRcpB6m8d
 u7y/MIRfzag8aPHL9bXDQZSTdYD40MkjLq2Ttp9LSpNNgJWRudrh3y2zo20e6sF/reQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=daulpM39; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=daulpM39
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2F3B40276
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:02 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso78401f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793312160; x=1793916960;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rimlw/d7nzZ4dC/7A0zgSWS8+swT7gQjGuQHOdP50eA=;
 b=daulpM39BPneSmCgERABWig9OLAQ5z6VPONKUChtE1d3RL9q1YeZCvF+qQLMjP2mwa
 wq5ph8B0I2XEPaVoqj9B/XWlWfrh5rT/QkKFtwFmXrzGcwU/8iJAvaFCIWjsGYdheoKk
 8TKiNjqD5pF0LD8NqoaYWngEIW7WA9l5ed03dQRrT5XIBuBrfsnbdFloYsX5KmvyEOkX
 fYUHH/PT5k83rS9SFzHylv+GYUdV+6Q4D9RlTuFenAP80dfiJ8B1EsEFUp2PFffyns+N
 cMhVBjOBfiioSxXy9VzRzrlLeylqOsWvS6v3Y2B8wZvqwHljeO1q17gU466ArhQ69dSR
 1SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312160; x=1793916960;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rimlw/d7nzZ4dC/7A0zgSWS8+swT7gQjGuQHOdP50eA=;
 b=I8TpVGEDUpEyyotWs/02quIixY2zQ8gSgS9lzpvoLPRnVsXOXlzATmnmO7HFIpde5p
 Kll0ChPGLyFeMfiNFxnrvBep2n0pxB9PUAThPyRemYyaZfxFN8tY0wPm9HP+K30rtjK/
 1+qKh/ogsuat4HlFpaU1R7EOGvnuaLW7MPCw/iDmZOuCCyQ++CW9m6nf/4E65598ZDMT
 sSLQWQbVPehlba8W0CDB2aKwIFY4uFa2XgfAVYL0jCr8voNA0iTR2JlJlpSTKfnGrsSk
 vVTnJ+awzUEoF+1ChfNnahE636GsVn4hRo02J7gxMZtUW0I+6KgxnT3JLmMNPaGJeXFh
 gBLA==
X-Gm-Message-State: AFq9FYLXrJU7oo40IEeUhkHXJdX8+PBuceieojN0XcfIOeDbegNx0LSe
 Dnj+oBlDPXe6a2+BV+wiFRdhtF+qNjd9AffbetJsMUBVDRBYwur30YnIOufZgUOKbf0r3A==
X-Gm-Gg: AYBFou39S60SD9kprs5VK571ef7Eaby7st6dPlLBBudAho3sF09TY33LYGKMwNn2eBV
 K/rCNiOJw2RXjojBaQ9OpM0hp5kiD7qdmthZaHiZ4MhocwNK9bbp0Df9UnkZbZWk6bStLXXQ9++
 VHzXGtxHnSDd8XR6UdyEv6ta/WDPc8iPkMLNGbd5/yiPLZ7cdgLxFX2vBfYpPDcfjCYXg4DAvFZ
 B6VrNBX+va81KAnb5v+JnysxJWYRQj0vZyezstL42btwJXk0AAytYDN9iwchroq/8T0+CWX5i9t
 naoqHH6FbYQ5Nj80JNqGlriRN2DWoZpiJg5nFbr4KXt63Co8l+uf620CxBfvLVXeq2J5vbctS83
 AYmJ8dEaVzC5oO3N0bR/t12r7a92/114Jsk7wBRK4DY6y49yOTwt4LqmLKqUSygHEUayvzTbTFJ
 Of+el2vCOG2zN0zfd4+P/iNsMkQ1hUVFCyzhaAMUP+VEWBMa3CagrqthMU8U2bLgt28klHe7LS2
 eaV318Ob39FalDxTRxdbR7s7le702jFQO4VL3UX3ZPHsmP+8dd02wds9p6rA1WMbrbno95gP3jU
 pUx3Z2rWGsgc0PWOiBmaKbCmfs+dz+h1cyRwz6VP
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4ac17d168b1mr7231955e9.11.1793312160307; 
 Thu, 29 Oct 2026 15:16:00 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.167.228]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e712b90a3sm53145f8f.19.2026.10.29.15.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:16:00 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 29 Oct 2026 23:15:57 +0100
Subject: [PATCH v2 2/2] global: Update references to U-Boot git repo URL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-master-main-v2-2-5c2c579e9eb1@gmail.com>
References: <20261029-master-main-v2-0-5c2c579e9eb1@gmail.com>
In-Reply-To: <20261029-master-main-v2-0-5c2c579e9eb1@gmail.com>
To: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
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

U-Boot git repository URL is git.u-boot-project.org. Update some
references in the documentation still pointing to the previous URL
at DENX.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 board/rockchip/evb_rk3229/README | 2 +-
 tools/buildman/buildman.rst      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/rockchip/evb_rk3229/README b/board/rockchip/evb_rk3229/README
index a8dcc40f09b..01839fe504b 100644
--- a/board/rockchip/evb_rk3229/README
+++ b/board/rockchip/evb_rk3229/README
@@ -3,7 +3,7 @@ Get the Source and prebuild binary
 
   > mkdir ~/evb_rk3229
   > cd ~/evb_rk3229
-  > git clone git://git.denx.de/u-boot.git
+  > git clone https://git.u-boot-project.org/u-boot/u-boot.git
   > git clone https://github.com/OP-TEE/optee_os.git
   > git clone https://github.com/rockchip-linux/rkbin.git
   > git clone https://github.com/rockchip-linux/rkdeveloptool.git
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 151123ccdca..9dfd32ad8ba 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -179,7 +179,7 @@ Setting up
    .. code-block:: bash
 
       cd /path/to/u-boot
-      git clone git://git.denx.de/u-boot.git .
+      git clone https://git.u-boot-project.org/u-boot/u-boot.git .
       git checkout -b my-branch origin/main
       # Add some commits to the branch, reading for testing
 

-- 
2.34.1

