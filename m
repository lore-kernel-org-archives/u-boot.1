Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEE606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eM9GG+yG;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PrGu7Nyp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECAC58177C;
	Thu, 12 Nov 2026 21:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zFuSXLT-cAku; Thu, 12 Nov 2026 21:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C8D8817AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518204;
	b=I/YfrmW39iLQbpZ/m0VjeQP9EHZMeeVAsFBzCdx2tXAmnOdPPXCa5PimavOeGBWxgTAr
	 SUZpTe/SBKEBZ9aEs24reeGazyhuzgdb9IZwCBPInEa0t5tIfxXyDj6GbsDOOd6Yae6LT
	 JmbzdN9VjLe6w31Krdg+K4M8thggG4tW6Gj642RQ2+IHToSVLAD054HOl6YGxECVuzG5w
	 nkDE43usps2Fx/8bC844xxzlW3UgmO/sxf3wlPmzBwgy3YdbV+5GC3kHyuKXjaYYUG2Lu
	 xnDSZhHF8JmOjZDWra9BoFHh4D51X+dphxGce/foJeDZIfUzqfaxLwgKHZtMY2eLC9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
	b=GPtaz2l3O4L5K0q/TY7GjopvdAXhLIG7hdbucNGrwxdteiNB1AEL+IZHGpyCct3nwPwe
	 dxek4sMPBwZ5CfTAqKi4BOoM9WK3dCcJ3jrdl13cdRXxgvgENsAdktJqvmfbS7Cs/G8K5
	 3Nwy6kUtNnIQ98e1jPVeHR1l2bf4HokGrWE9ScTPM2OqF0+r9KT3bysCFq+3/2teVr5AZ
	 t/Cnltdf0VE8PXv+ttfwHEFfTJAMiauajFSw6B1bgbJgsAb/hORfTkt57J2blY12+m9z/
	 TPDvO1BN/z5nViwaQXe+ouPfAd2ad1upD5Ck7lycD3Ft7O0srGT5GfY1VLqeGKJtQQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518204;
	bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eM9GG+yGKlmecOlBqdB6QMom82Zl5XJ9AZ5CILeUgacW/iLPBHFbvI9f4kzjgaEIo
	 aQ8MB4W8Gq1Ma6o5WeOD+MEu/YrU+EcNB4qPEG7TKlzMC4ktl4oujfqdyRplnVFi0h
	 3VU4m2+HKtsXqcWREB1pmtyvP/Fq+c/fcw43tQ2HUIxk7QiacNNCWC10+pVlWP5rxt
	 mxxmGbCf/kioyw0jv6MD5quthKMLQSOq6ZP+xK+/h22PKMysmJILbz4X2A1qnVHVrX
	 qGN+qmjLvxT+DyjWpNuW0qMaaa2dauGHYzx9W4TZxiA5Zu1pz2OS9Qk6YJKIAFcxgs
	 Q2JnNOCJazynA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C8D8817AD;
	Thu, 12 Nov 2026 21:16:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42E421790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34C594005F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c0JHsQWHJjm4 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 48AA94009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PrGu7Nyp
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48AA94009E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:38 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-5642e0910a3so180653b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518198; x=1795122998;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
 b=PrGu7NypFx3Q3yeF3JEB5DnUwAiEI8YxaamuLPA3Qj2aBT8UWTWwCx41C0ROBnf3oQ
 QuGZLn9urZJ83Dt0hx5idmnXme6svYdyof5gviPHyqUnJqoEYIF7/JkQxmp+V4WtOA2B
 KS1TOvK3iw9bZ6+PnjQaR6z9SKPnXPbUUSZs5WMwmp1sWeXtHDAI+wrjPqcJ57saH/J+
 2AqnCwixI8hYlQJm2UEmJ9BrnNip1x4PxynDSZCcnFxu/z4sH6pMoxjDHFXqmtiuVq3I
 LztEGG0PKUvs36bvZGOS0QJ2L9+Ufr6gvblPuAq8y7EfZRsZls2q0GhWynupWjYNGIVy
 uhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518198; x=1795122998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CEXj2+xi0vCFvO51IkoHt3FUqY2utfFrPkP4DqWAeSc=;
 b=GsfVUJSALlhEOHr7gpxZuxtIjrqjbdMPfFQ4fncyc4XBrLFkBOk7p6EyYQ2Kan3wqO
 mPJ1mg192REhYwwrxyPnCnLqFrR13RZgEsapLbw1WLX3YNdNwdXpoMQQqmXym+mNne1V
 o6Prx6s7eC7WkZNF1Inzj/vkYh7lT4fzxPjnviD9/zmo+kFAuyA6r8vlK6J3hzGH7mUD
 rjBOyFQD9/c5pajOc0tptJSBkU2cwdcAlZuQJvhky3RTVUsjX5bNtUtQFMZ09KB2NbtK
 LsnClQ+R0k8fqMNNrrseE75/ZXYOjTN/C+ClEy0/+PTzOz8xCei3tD5Ou8iILJKrwK1v
 QK5g==
X-Gm-Message-State: APuU4Z8CVNpUdSic6SZNahDrX6GLY+8D4FrJI9PHLJWL8yFbQMvpifcI
 rKTzEXqJ/G2Hg0Zrb9Xq2j6BufkU4rMffqm0UspqSOpIXE6J0/8YnOpTp9mvDHfuh9g=
X-Gm-Gg: AYBFou1qhYsJ9IPBFRZtzXTbNPK49ZV1LiXmFgrvdG+ZJBpRN7+JUpFCcCpK5Pl1jnl
 jzjiLYV12FBxf+thLHHmEAhRtmDp4uCjPz+ejwhxhD4IGS4aOOz2R3icAhH6Tb5iwah8hvZydAC
 AdQdsJSlHGyKMS+rtNCh9npx5XUerA+otk+M+PqsXfMjqQ54wfYhObR8j68cQsalDmp2lEcSvQA
 CbWgHzDACTBDSKXMP5a8JexBG7Q72jGrfngDRvvhC6lUDYQtYFb84jYN6dqE/dK+XQYT2oyPRhk
 L/u+9i3qLXboUSpoW1bWsjQbfwJkOFXgO4nGO11pwgw1V3z/72IHYs7ZrguP/LDQuZzZxYxMqHC
 sGhY0ENTYS1BKjg1doO1/Y88riJwZU5kEsHooxjnHYv9FOUEWMYNKcBO1e7uh54SNGPIqkZddXF
 Hsbi0RJgTFqV+ZhKu87kdpby63tpyTNobeW5IZg7DC65pF4TFgXVgSr8NVMt4SpLCsjvD9LmpN8
 474YpcijimfAOJDNLSmM2OgofaTKoPN5v4Gw9XnRxCoRnHMHj5IGajirc4x+Dd/g3fWQ2I659SD
 7/P5J055n3BMS/1H87qIawgQam4GYEXoiQ==
X-Received: by 2002:a05:6808:6401:b0:567:fb7c:5e51 with SMTP id
 5614622812f47-56e65001952mr429266b6e.50.1794518197620; 
 Thu, 12 Nov 2026 13:16:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:15:01 -0600
Subject: [PATCH 06/10] binman: recommend a separate devicetree for the
 image description
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-6-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qVK5YBtFo/QtWkP4D5ghtgS9HJyV0TZIRy9caTnVb6I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9iyEkiBuAR2ingz1+u5QSY9qvQ6KgWL4tmxKs
 45A4LEG8r+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYshBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwpsH/0PuW0AzRKuo+ibKHYem90h1oxtVX5Nem0G03Sc
 89PkSA9VXXJq/NoKCuLv5+npnpTFufyAcsHOesWJeD2xTmfLMdKwzFawhnS9MmsxIMA6WsxjTas
 Z2n01IriYWQrVxf0pTx1MK2UUfcz6dN7FM0j5iyTQgXiRXpsWnRVwvYPtkuTmr5GYmgYjnEPzYV
 dgQEnyvZdqz+vYCJLEf/fbYRB8jVPRVDNtgJXTs/SNrl0jaJ4qrdwgZPdJuTs+RcHyv6mnOWIV3
 0KE2a5eLOaO7T+DbQyKYte9RgzkeaId5+oVquAdb7i347NxJCB30jc2QTP8OPY/t4V4IAdo63a5
 vZzs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Recommend keeping the binman image description out of the U-Boot
control devicetree when that devicetree describes the hardware, by
putting it in a separate devicetree selected with CONFIG_BINMAN_DTB. The
binman node does not describe the hardware, and boards can now keep it
separate without losing their u-boot-dtb entries.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 tools/binman/binman.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index abff7e8a414..9acbe558f0d 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -287,6 +287,15 @@ same files that describe your board's hardware to describe how the image is
 assembled. Typically, the images description is in a common file used by all
 boards with a particular SoC (e.g. `imx8mp-u-boot.dtsi`).
 
+Where the U-Boot control devicetree describes the hardware, e.g. when it comes
+from Linux, it is better to keep the binman image description out of it, since
+it is not part of the hardware. Put the binman node in a separate devicetree and
+select it with `CONFIG_BINMAN_DTB`. That devicetree can `#include` common
+`.dtsi` files to share the binman image description between boards. The control
+devicetree then holds only the hardware description, and it passes the
+devicetree schema checks. Keep the binman node in the control devicetree only if
+U-Boot reads it at run time with `CONFIG_BINMAN_FDT`.
+
 Where a particular board needs to make changes, it can override properties in
 the SoC file, just as it would for any other devicetree property. It can also
 add an image that is specific to the board.

-- 
2.53.0

