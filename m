Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B55CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 03:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63C5340C00;
	Fri,  2 Oct 2026 03:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQ4BSZT6ztgV; Fri,  2 Oct 2026 03:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E9E8540B48
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790910831;
	b=CON0QXRWZo4WTsjECGrF74Ntqrn4UWIL+OahETcIZPykg9iZaXWlESaPkTJoNxQaPc8b
	 xdcxuvAdxDc/9ys8ploMSzCjnZxeR23tJ8bAGoWxIUowM8SmOvPwq7EwGcesnRu8ZnF8K
	 QMZA8atGDygGnBcuEjfPtS5ZgzWFa2gncr4JS1ZKnJL5qbIyMhStFjU+UUsCf37kCyuGo
	 9uZNAzFljaGG6NkUVCu0ckO6hVF6aDAUuHfv2//jVbpdGnDAT1hE0vS5qpG5wMt/8ccTk
	 7dGYguUEjGhqkNq5ul6Fw9kX36erQgKbTt6g7xuJr1Yfswo8UcXX8wlq73W2J80qx8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790910831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gLiNA+Q5LSJl/hLnGf3g3Fo+zk8Lgz2amVuehkPHbQM=;
	b=icPhNQCnsGeg2XeF1FD6Jg9It5MMxfvXWsfJ/gAP/MA/B7AmtFYgHif490peSapD+Cv0
	 5gpAzvaxoHP4KiL4ouSRrL/LPjQlFc1VzZI+0wWne9WW3kB/EwU73Y27nNMghl42NZWqv
	 g+CuLEVPHn50hDHZ0FRkCQhQVAdIvkVvwoB2cNoOOXhgSdO/1T6B8QqPLIzLtMYhiFoDI
	 /SKmNtddlr9rmsSSGyHvZnk3TJZVyCMZLq0oGoky2fdZ6Vhp/8Agnt4ahBNA0GzvKxBEZ
	 DohR2hOpjj8Xl5OhnMhpGfHt4fnLWD0AbSu3Os52sB85mxwGb1fx0m7NgiPreKbo4hQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790910831;
	bh=gLiNA+Q5LSJl/hLnGf3g3Fo+zk8Lgz2amVuehkPHbQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHxOzZEbZMz+qZMX3QHRry6u4ALR1hMQIkAz7G/pPVMkRhrcFZBJ8Vm/2iqasthWU
	 5yEdhcUR7O6SFfThraWtzhBe0B+i1qMaZ+okklsuqIVr/SnQfw3SjuLf2lCS8V+SV4
	 S0QAqN8rU25WE36iegI+xcuQP9xtk40QjDQIVTy1K6pABt96Okh+hIVQo0/gUHAGTu
	 0GnJWq8Kjg2rqHgI4MlioNUJ/RIOtiyRrJVGwxcGPB+s1LEwvr/vEXVwrWb66/BCjw
	 Z/P9svk9SBBbl2YLesQqARxknKYLsAgZWBcQs6GcRnyXT+hEzsBaXkUwLJBx+WpT7F
	 xMDZm1vqFXwuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9E8540B48;
	Fri,  2 Oct 2026 03:13:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D33D1A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7337740062
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QuGj3PkwALzO for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:13:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9F904400E5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1062"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790910827;
 b=nOOydl7KY99veiL4x9fQsCm7KVM8m2AwzPP9OiRuPLPqy0O2Hgz7zgDyKhNaUYfwToa0
 uygpeHQ/m3nkkOiaJyGzrYQ5hmL3JGLTE34UN+1HaT9nYXn25BSGBhHmrvC27QXmbsmPi
 ZAcFL3r0nY7t5ifhMEM4pbbEuflP9CoFktg5nxIpm4b4Dg60Zbu5smluNHsBn5zNbxFlc
 N5sy0RnhqH9Os/D81XYzOFV/Y7KejoNr9iJPXrhM0KTjc/RV7x11Dki1mFyaJc8RlKFUE
 FLyLQrYG3nM3CCoPSXy4vSbcnkM30fKzvnLGpC24xa3orYjMZSUVPyXVt994ISKuspA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790910827;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=gLiNA+Q5LSJl/hLnGf3g3Fo+zk8Lgz2amVuehkPHbQM=;
 b=lE+xzj8ujUQBl7w3FMCmD387/RmQWkNTk+p33b9EMFIgz+HEXuldACveAj+aIVCIpHkb
 vjmrPxfMASqDG5x+81mhkWBXGYQv3dHSalB+i0nCk3WEgd6eot3u751p13R89h/h7phAK
 lKqgmgEGt53QoHtXhR3jC4RNC8fDHhQT6hpQT2Mh4AKJ4ISF4aBN3iN9t2L39RF45rM5I
 J6QwIfUPP19p2cruOlmO9f3VsWWHi4hExmafKcD2pHMtHKTmlGn4t8uIRlqTO6o7jVSod
 PVGBO0aOcr4xVl+7fpjTvzzPzyya7HF5Z95C2seFXoQXw8HM86414QjbE2s5vkraLYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=ausil.us; 
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=JvfCS3Hl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1062"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1062; helo=mail-pj1-x1062.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us
 header.a=rsa-sha256 header.s=google header.b=JvfCS3Hl
Received: from mail-pj1-x1062.google.com (mail-pj1-x1062.google.com
 [IPv6:2607:f8b0:4864:20::1062])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F904400E5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:47 +0000 (UTC)
Received: by mail-pj1-x1062.google.com with SMTP id
 98e67ed59e1d1-3a4b9732d5aso858722a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 20:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1790910826; x=1791515626; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gLiNA+Q5LSJl/hLnGf3g3Fo+zk8Lgz2amVuehkPHbQM=;
 b=JvfCS3HlgXseRPBC26ffAZyyNIyXQWSvlPfrsLYRqYUEoPGc4iYcxAWPW9fREJRX+T
 ZdQX2HOL4WuZ9I3IzUGLzL6IwLCeDT05CAFLeIWuqOibJyr2rgz/4EPo8aBPfJSbh7bu
 arI1pIh0tkMiFx5VPpKLxI+vQwOzGtRIvgC7omYdwBY6EAlqrA6YWsIPegLtrgp4wn9L
 IgAvn8EIs1GS1CkkKJOP8sheyRpe500UKMox4YyCRBjHx8mB3xI7im4JkYys5mMTEJD+
 hgQu8msnleJaSwznyHCM/CPMG3gMtOqEeWhQqODGRGhDmJJ87dCPfvJad8mdgQl7R9co
 tDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790910826; x=1791515626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gLiNA+Q5LSJl/hLnGf3g3Fo+zk8Lgz2amVuehkPHbQM=;
 b=q5IFphQGwatbETxQYvpJe8PWEO+e/lOgiBpA8qQJMT8ZwgOfIv32UE1dz95fqPcTBm
 6GHL/8mlhbLYmWNOi4rbEmXX177+aCVfBFEN5YO120RRkxx453iKe0xaGPIaui9G1S0p
 aUBDd3xWBuw2qDes6uW7UVGa0uQqA9atrwSrdHLYjlxwM71Qf6sggSabICmrYJjTwnBK
 1RQC46O/X0kRrBMtcXIuRUDKygiq/QyXOGPhUTw3m8RCkw9gudbC5ses1DetoawrkNs/
 l6r4n/NdAUl6eHz10ptp/VLUjZL+SUITALJ5tEeI3Ol2z6P1cYBaD2YrSxvabojO5C2b
 yMNQ==
X-Gm-Message-State: AFq9FYIk1/sdb/fUHGdiY3AoEG0En/aufCBhccoIKF6sE4hMOskQSIGu
 XGlBPxDYSit3k3HGFOCjNdWOuQKLqzERWHZHS9/g3XQiyRprpdnZD1DEC7Ln3UHjAslrrbUdDQ3
 orEHIpVuM5cKAYNKbAvGf02YzHw4Bv8TrdPiJD7nPGhI0
X-Gm-Gg: AYBFou1LWpTnRcM2028lx5dIxoE+bYl3cDeIyUCiiRKekev886Rviu23wQfgVAp0F9K
 tlVulW9FRwT0xZToC6mPnQ8gxbyJvghFkCeOyc3ytdiRTLN7Wguu/Eg+lpgQSRACHA4c79q93wq
 7NBiDxNwmdiYp2O4GVvGoq9fhanUUamIpuz9asmhZH4NvfV5T7e3NzfmVkLjgCei9DbcuHHyWnX
 aUINUANVMR6XY02GUV5wzMtjZ2MjQ8p1159HjOkm+72cIvbuTFMl1Bpqooa/eQ9RqbChMht7DIG
 Xya9HboyCuLy/E2VV6LTiW26IoKFlceCwJHVqjGjiJvOhk9H5onQm5Xmo/UMcZRcipAg8ejLhh8
 DzhM0lBExegwHjo+iAb/pSNg=
X-Received: by 2002:a17:90b:57e5:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-3a6ce3a9724mr1361134a91.2.1790910826536; 
 Thu, 01 Oct 2026 20:13:46 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6cd60531fsm834715a91.6.2026.10.01.20.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 20:13:46 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
Date: Thu,  1 Oct 2026 22:13:30 -0500
Message-ID: <20261002031334.3285687-2-dennis@ausil.us>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002031334.3285687-1-dennis@ausil.us>
References: <20261002031334.3285687-1-dennis@ausil.us>
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

Add compatible string for the Orange Pi 5 Pro.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Link: https://patch.msgid.link/20260511025352.106126-2-dennis@ausil.us
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 03b1c32f54bae3a4e73f82e1ccb322cfead24a2c ]

(cherry picked from commit 77c77cf4f0f1a9387720d9052673cdb9a01645ed)
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 dts/upstream/Bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/Bindings/arm/rockchip.yaml b/dts/upstream/Bindings/arm/rockchip.yaml
index 1a9dde18626..ec130314060 100644
--- a/dts/upstream/Bindings/arm/rockchip.yaml
+++ b/dts/upstream/Bindings/arm/rockchip.yaml
@@ -1338,6 +1338,7 @@ properties:
         items:
           - enum:
               - xunlong,orangepi-5
+              - xunlong,orangepi-5-pro
               - xunlong,orangepi-5b
           - const: rockchip,rk3588s
 
-- 
2.55.0

