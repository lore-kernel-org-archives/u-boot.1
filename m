Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386BDCC6B2A
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C608081516;
	Sat, 17 Oct 2026 04:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1IlnCUb35FWU; Sat, 17 Oct 2026 04:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D33BE8156B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211799;
	b=QASozVpIajkyP4lTqI2XzHHW9lk/TiC9w+NUQGQGPSuQiI2bvOH+tJE2pyk+hhMk3ZVh
	 BOcvJRHAlJ19fgJTTTOyMHdrJl/fj5iO6STpl3UHMdMGaDXA0QiovlAIaCICbsF2k2cr5
	 Fm1GyH6KysCoAJ+/W4ju3WxRFFp268+GnL5gykoPr70973bJVQM1RYsSP0qVyV+dkeTQk
	 qDhgs0dbwEioreYjBA+E6HyWcutcs7H+sadQ47k7AnPTGHHeO3ef/ah59kYAg7vUkXniU
	 rDnYNC16Ee+L4HNHAprpvTgdCUuC/isTsZGcjThIlBPtAsYmlKBey0Ri3RDWeMYA3mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
	b=jzYlyJJzAoVDeQNar93zIJ6gkx57LVgFYBNs78X0/YVIgbt4Tl0X3Lpx1DEqrKSevwfN
	 1NapdC2ACEvD/NQPh8hlVp13icrH7a+RBQvqH3OdOvTsFoemjxOqNaXrWHBlqXjXxg+cz
	 ovkyle2INwbBn14A8K0+KukCoxOW9DNJAwjVUpM3Ib66sfIBunXqkiDvOeWNobeV0h7k5
	 jNdQ9spVfzZV11EZFlWu5aG8lMHJOLJGSI4p+Ab3ec+Z9uiM5jpiridHD1lL06sqGTDfQ
	 1upJYaolGjtcOQCqF3i6vroow62ZrHKU/Doekr9nWf/CYBzSM+fqqWJa09S8w2p+C8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211799;
	bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vfR89TAg8cbj+D6/t3jpRQzXWB8LvZxi+TTbU0Hpib2inBezFyg2chxn++fKpkxPJ
	 9hmD/3klz6b0TuW+xEOGQNnj9ddNsOSBgr4TAZCyeZmILhOiynqi08Ryp7PzdalFB5
	 Ao2LHyjsDvb6btRgU5HWaWXA4xq4rPofdDCHhAunRuJ4Qm6s1IPPcYn2nTZLxM88aN
	 1b6TQJAKQaeyNIe2FHM5liG9XUXIjxumZTzPtUsE9tNW+u9ig/7DpSqch8UfZtomqA
	 HRx8cAkEs6VGf2DOsFd/jSeNTdz4kpSJNgLRnOSJU6K2Jdtgf3d3AzmqXtLRoE1yzz
	 8Mvp/LNx5Z+TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D33BE8156B;
	Sat, 17 Oct 2026 04:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EA2B105
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CAFC409C8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EFE-1U9BGjhH for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2780D4022A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197360;
 b=nr7VsU4tRaJwgGLNp9q5olbY3ru5QzRfcJP/9R0TAf10UNykBq/flgCqkI4DAqG+4/zE
 zq+YZC+0Rg/0LJHtL/btMltyNZPitDxv3B2b9/pw819nrTX1gZLrAgWvlVsVjhrF85dp2
 XzRLPwV+fGut5xDC1I36bh8evHp3ZT1owvOQuGJNXGNu913tfu/qlqdFwRirWyBRExYHj
 MgsgXZdsCDMy7MePlcQpBvF8moKC4b6i0REKqEadPM/9WWRTeD0Desw2PC4uBxyhKBRml
 fiNmLLyQs+r53Q4gsAkLZ89cD2jWAfXRbH+g0ejX0L9hfZfqdVibYxnN9ZAH2D+Z3LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197360;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
 b=cwHfZ9Y+5bZ1spEbGrAhXypbqg1iwJffR87CN2w2VtgGD70FVU0WVbsJ2HW9WRZECK/b
 na/sScg96ey/MeJD+0Rxerqv2qBtsz64STFwLyPTeU9U/VhW8snMY6zc2zCanqn9b82Qq
 JBCgFm119rEMQ6Un4VoVl+aL308flwoQPTQfD9wskBSj8KJbb+BdDX8w+JWRqgWX7EHse
 Wt/AN41/nihSr5fskTBb/lnBWJNfwrK39ocAmnhm+wTU6Mzu+2ImhhFcH/7Dadly7uRSa
 j2LKq9nPH91EjFTVspX7791b3FJ1I23cYeBs4ZnnWREsMKwXhRPe9AiuPrRBEposRHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DiYMHxUh; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DiYMHxUh
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2780D4022A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:59 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-46556b9e02cso410377fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197359; x=1792802159;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
 b=DiYMHxUhM8ZFbPNOmTFRnIVw0+YFFcrY3kEMdJrgW6jBpbe/W22gZ7+lhEwUa2VEYT
 s10NUmA2gY0xaA0+GBSYaxUTY3r6v4lUXKroD2rEjFOcu0+P8cidqVQQDDVuYY5zDnfB
 uCJp/aa6ARvTn/QryvD6Br7TjzDb8VcT5glpjCb/QP/uyFZLT+1xeUqZQdW39JhYEdCp
 IqPR9xzlZieJ0t+pHbkWg0rd4PRkj0fbX9jJmog57G3sDCyBMEmSnW6d7zbaT/ysN0v4
 v5LzUd8sfiMZmJc1SiBIBgU59RQPYkRwd3Ey1UsFUc96P6+BzYbaO3ySHtyXJD6o2hyw
 H9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197359; x=1792802159;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=anL8dCf1pJN0E4ieBeE26RQ+8fbqGghGUFn46NQ/BmM=;
 b=i7HId7nnfeuUeQVSaSRzqepl2UBKrfPD8ClWVN6hsVYsXp9wZ5ccy9NcacDrUcTXUz
 F2AqsPWQpHeGRQNmd6aX5uT3KtwtsFwIURPZuZzFZZ7Bu+bJMy44c52MKXmjPMHlx7l2
 V3yXXQ97iQ6CbH5UJGHObj0HL66RE6MGX/rbgrkZ6pNYGCcsXUUmZuRENApz/rN8DpZ3
 3ED5XG1c9yMrDoWrBONOA5ItttDXD7IgUEyZOO043AVAvY5YQL+IH/RScHvr17WmNawC
 pWEkB5jHu85LctNB0QQ7THYM0u+prZ2wDQzmR1PVW/51uLI+KPKZEjE5ZTL6uA/a60yR
 KSOA==
X-Forwarded-Encrypted: i=1;
 AKwUvByrAxyPID/QwmnGeJC2fzSzhgs50zCHnnGxC7Mv/pwSjV0oBP71KfzCSzyI+H8ChbRnokVJSQ4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKaxuPZc/riQYUBmK3q+lne4P/FqzyblZTdOBGk5V8OL+GWAaAb
 YboE3KZCAyZZj+eW12TMnViEz+CvCax4uv4C1K5bjWNFKClK4GeYGb0N
X-Gm-Gg: AYBFou0LHY1p23SFvYhn26HVHJONUHc/+WjnbpP5jFYf0zSSgheXDLbSwyrZrMflCEJ
 9sKwRCotZrIWUm1J39tI8j9zo2b/RG5HMFhagDev4DC+lxQeMFzlKoXDvixEdz6gAM3YmgF7Zb9
 zLB0sKAb2xgTXspm85a+7Wwd/R7YJGqboD0Zqj2N7xXe6Zi2rQk9BiT+iehxMZTxIp106Xd6+kf
 ipUg+Et6MA25Iyv6cl0n+ok9Oz4IWEeIYLqMY5hJ6GUJVmm4jacvjzVkdSC5d+2A9Eb1h4Vul+2
 +MuQgvpencjE1WkhFk3+luUqhbs2tgwgd+sUea9waBI/h77aJoHJA4sTz8KcsQpmdmAe1tYhnHN
 J9gLw4y4iIabzppXU+ZCWvpyHpasd7tPO6Pt42eHUDtAxbaAknqSMUQr7G7210jLJcZqI1sWoA+
 7N4wmYEKrubpnqXtTfj2RcUaMCtwgXg11Ugq69Pir+WGh7hShVkXAKDs1c71RA7VsJUAHtm63PA
 jJAk4JBPxGyBpVe6bk7zbJTUoG0P/7wb3tjGyEzHLF7Sct6dC1Uos3f2VcOptD2DUwnDhKfrUVa
 jSC/lHKVOaBDXwk7r27PxBkTR2jFXapiG+BpL3mgbdgJnRwpoClSI4D3MPXfz8Us45Xtoiv1fmI
 oI16a8RtOt3XkwHaSkrlGRw==
X-Received: by 2002:a05:6871:c684:b0:498:8e03:c1e0 with SMTP id
 586e51a60fabf-4a730be8f20mr2599676fac.40.1792197358611; 
 Fri, 16 Oct 2026 17:35:58 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:22 -0600
Subject: [PATCH v9 08/17] crypto: aes: fix software key-size handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-8-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
In-Reply-To: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 17 Oct 2026 04:36:15 +0000
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

The AES uclass API expresses key sizes in bits, while the common software
AES primitives take key lengths in bytes. The software provider passes the
uclass value through unchanged, so AES-192 and AES-256 select the AES-128
round count and key schedule shape. Key expansion also copies the bit count
as a byte count for every key size.

Validate the uclass key size, convert it to bytes once and retain that byte
length for the software operations. Correct the primitive API documentation
and add NIST ECB and CBC vectors for AES-128, AES-192 and AES-256.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - Drop stale AES-128 wording from the generic primitive docs
    (suggested by Simon Glass)
  - Return -EINVAL when no software key has been selected
    (suggested by Simon Glass)

Changes v3 -> v4:
  - New patch
---
 drivers/crypto/aes/aes-sw.c |  45 ++++++++++++------
 include/uboot_aes.h         |  24 +++++-----
 test/dm/aes.c               | 109 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
index a65200fb79b..4ec9484c608 100644
--- a/drivers/crypto/aes/aes-sw.c
+++ b/drivers/crypto/aes/aes-sw.c
@@ -12,15 +12,25 @@ struct sw_aes_priv {
 	u8 key_slots[SW_KEY_SLOTS][AES256_KEY_LENGTH];
 	u8 key_schedule[AES256_EXPAND_KEY_LENGTH];
 	u8 selected_slot;
-	u32 selected_key_size;
+	u8 selected_key_len;
 	bool key_expanded;
 };
 
+static int sw_aes_key_len(u32 key_size)
+{
+	if (key_size == AES128_KEY_LENGTH * 8 ||
+	    key_size == AES192_KEY_LENGTH * 8 ||
+	    key_size == AES256_KEY_LENGTH * 8)
+		return key_size / 8;
+
+	return -EINVAL;
+}
+
 static int prepare_aes(struct sw_aes_priv *priv)
 {
-	if (!priv->selected_key_size) {
+	if (!priv->selected_key_len) {
 		log_debug("%s: AES key size not set, setup a slot first\n", __func__);
-		return 1;
+		return -EINVAL;
 	}
 
 	if (priv->key_expanded)
@@ -28,7 +38,8 @@ static int prepare_aes(struct sw_aes_priv *priv)
 
 	priv->key_expanded = 1;
 
-	aes_expand_key(priv->key_slots[priv->selected_slot], priv->selected_key_size,
+	aes_expand_key(priv->key_slots[priv->selected_slot],
+		       priv->selected_key_len,
 		       priv->key_schedule);
 
 	return 0;
@@ -42,12 +53,16 @@ static int sw_aes_ops_available_key_slots(struct udevice *dev)
 static int sw_aes_ops_select_key_slot(struct udevice *dev, u32 key_size, u8 slot)
 {
 	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int key_len;
 
 	if (slot >= SW_KEY_SLOTS)
-		return 1;
+		return -EINVAL;
+	key_len = sw_aes_key_len(key_size);
+	if (key_len < 0)
+		return key_len;
 
 	priv->selected_slot = slot;
-	priv->selected_key_size = key_size;
+	priv->selected_key_len = key_len;
 	priv->key_expanded = 0;
 
 	return 0;
@@ -57,14 +72,18 @@ static int sw_aes_ops_set_key_for_key_slot(struct udevice *dev, u32 key_size,
 					   u8 *key, u8 slot)
 {
 	struct sw_aes_priv *priv = dev_get_priv(dev);
+	int key_len;
 
 	if (slot >= SW_KEY_SLOTS)
-		return 1;
+		return -EINVAL;
+	key_len = sw_aes_key_len(key_size);
+	if (key_len < 0)
+		return key_len;
 
-	memcpy(priv->key_slots[slot], key, key_size / 8);
+	memcpy(priv->key_slots[slot], key, key_len);
 
 	if (priv->selected_slot == slot)
-		priv->selected_key_size = key_size;
+		priv->selected_key_len = key_len;
 
 	priv->key_expanded = 0;
 
@@ -82,7 +101,7 @@ static int sw_aes_ops_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
 		return ret;
 
 	while (num_aes_blocks > 0) {
-		aes_encrypt(priv->selected_key_size, src, priv->key_schedule, dst);
+		aes_encrypt(priv->selected_key_len, src, priv->key_schedule, dst);
 		num_aes_blocks -= 1;
 		src += AES_BLOCK_LENGTH;
 		dst += AES_BLOCK_LENGTH;
@@ -102,7 +121,7 @@ static int sw_aes_ops_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
 		return ret;
 
 	while (num_aes_blocks > 0) {
-		aes_decrypt(priv->selected_key_size, src, priv->key_schedule, dst);
+		aes_decrypt(priv->selected_key_len, src, priv->key_schedule, dst);
 		num_aes_blocks -= 1;
 		src += AES_BLOCK_LENGTH;
 		dst += AES_BLOCK_LENGTH;
@@ -121,7 +140,7 @@ static int sw_aes_ops_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
 	if (ret)
 		return ret;
 
-	aes_cbc_encrypt_blocks(priv->selected_key_size, priv->key_schedule, iv,
+	aes_cbc_encrypt_blocks(priv->selected_key_len, priv->key_schedule, iv,
 			       src, dst, num_aes_blocks);
 
 	return 0;
@@ -137,7 +156,7 @@ static int sw_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 	if (ret)
 		return ret;
 
-	aes_cbc_decrypt_blocks(priv->selected_key_size, priv->key_schedule,
+	aes_cbc_decrypt_blocks(priv->selected_key_len, priv->key_schedule,
 			       iv, src, dst, num_aes_blocks);
 
 	return 0;
diff --git a/include/uboot_aes.h b/include/uboot_aes.h
index 592b7dbee43..e463d5b0c42 100644
--- a/include/uboot_aes.h
+++ b/include/uboot_aes.h
@@ -47,30 +47,30 @@ enum {
  * operations.
  *
  * @key		Key
- * @key_size	Size of the key (in bits)
+ * @key_len	Size of the key in bytes
  * @expkey	Buffer to place expanded key, AES_EXPAND_KEY_LENGTH
  */
-void aes_expand_key(u8 *key, u32 key_size, u8 *expkey);
+void aes_expand_key(u8 *key, u32 key_len, u8 *expkey);
 
 /**
- * aes_encrypt() - Encrypt single block of data with AES 128
+ * aes_encrypt() - Encrypt a single block of data with AES
  *
- * @key_size	Size of the aes key (in bits)
+ * @key_len	Size of the AES key in bytes
  * @in		Input data
  * @expkey	Expanded key to use for encryption (from aes_expand_key())
  * @out		Output data
  */
-void aes_encrypt(u32 key_size, u8 *in, u8 *expkey, u8 *out);
+void aes_encrypt(u32 key_len, u8 *in, u8 *expkey, u8 *out);
 
 /**
- * aes_decrypt() - Decrypt single block of data with AES 128
+ * aes_decrypt() - Decrypt a single block of data with AES
  *
- * @key_size	Size of the aes key (in bits)
+ * @key_len	Size of the AES key in bytes
  * @in		Input data
  * @expkey	Expanded key to use for decryption (from aes_expand_key())
  * @out		Output data
  */
-void aes_decrypt(u32 key_size, u8 *in, u8 *expkey, u8 *out);
+void aes_decrypt(u32 key_len, u8 *in, u8 *expkey, u8 *out);
 
 /**
  * Apply chain data to the destination using EOR
@@ -86,27 +86,27 @@ void aes_apply_cbc_chain_data(u8 *cbc_chain_data, u8 *src, u8 *dst);
 /**
  * aes_cbc_encrypt_blocks() - Encrypt multiple blocks of data with AES CBC.
  *
- * @key_size		Size of the aes key (in bits)
+ * @key_len		Size of the AES key in bytes
  * @key_exp		Expanded key to use
  * @iv			Initialization vector
  * @src			Source data to encrypt
  * @dst			Destination buffer
  * @num_aes_blocks	Number of AES blocks to encrypt
  */
-void aes_cbc_encrypt_blocks(u32 key_size, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
+void aes_cbc_encrypt_blocks(u32 key_len, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
 			    u32 num_aes_blocks);
 
 /**
  * Decrypt multiple blocks of data with AES CBC.
  *
- * @key_size		Size of the aes key (in bits)
+ * @key_len		Size of the AES key in bytes
  * @key_exp		Expanded key to use
  * @iv			Initialization vector
  * @src			Source data to decrypt
  * @dst			Destination buffer
  * @num_aes_blocks	Number of AES blocks to decrypt
  */
-void aes_cbc_decrypt_blocks(u32 key_size, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
+void aes_cbc_decrypt_blocks(u32 key_len, u8 *key_exp, u8 *iv, u8 *src, u8 *dst,
 			    u32 num_aes_blocks);
 
 /* An AES block filled with zeros */
diff --git a/test/dm/aes.c b/test/dm/aes.c
index 702e4db2b35..c58a5e257f5 100644
--- a/test/dm/aes.c
+++ b/test/dm/aes.c
@@ -29,6 +29,8 @@ static int dm_test_aes(struct unit_test_state *uts)
 	u8 test_output[AES_BLOCK_LENGTH];
 
 	ut_assertok(uclass_first_device_err(UCLASS_AES, &dev));
+	ut_asserteq(-EINVAL,
+		    dm_aes_ecb_encrypt(dev, test_input, test_output, 1));
 
 	/* software AES exposes 2 key slots */
 	ut_asserteq(2, dm_aes_get_available_key_slots(dev));
@@ -55,3 +57,110 @@ static int dm_test_aes(struct unit_test_state *uts)
 }
 
 DM_TEST(dm_test_aes, UTF_SCAN_FDT);
+
+struct aes_test_vector {
+	u32 key_size;
+	u8 key[AES256_KEY_LENGTH];
+	u8 ecb[AES_BLOCK_LENGTH];
+	u8 cbc[AES_BLOCK_LENGTH];
+};
+
+static const u8 aes_test_plaintext[AES_BLOCK_LENGTH] = {
+	0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
+	0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a,
+};
+
+static const u8 aes_test_iv[AES_BLOCK_LENGTH] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+};
+
+static const struct aes_test_vector aes_test_vectors[] = {
+	{
+		.key_size = 128,
+		.key = {
+			0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
+			0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c,
+		},
+		.ecb = {
+			0x3a, 0xd7, 0x7b, 0xb4, 0x0d, 0x7a, 0x36, 0x60,
+			0xa8, 0x9e, 0xca, 0xf3, 0x24, 0x66, 0xef, 0x97,
+		},
+		.cbc = {
+			0x76, 0x49, 0xab, 0xac, 0x81, 0x19, 0xb2, 0x46,
+			0xce, 0xe9, 0x8e, 0x9b, 0x12, 0xe9, 0x19, 0x7d,
+		},
+	}, {
+		.key_size = 192,
+		.key = {
+			0x8e, 0x73, 0xb0, 0xf7, 0xda, 0x0e, 0x64, 0x52,
+			0xc8, 0x10, 0xf3, 0x2b, 0x80, 0x90, 0x79, 0xe5,
+			0x62, 0xf8, 0xea, 0xd2, 0x52, 0x2c, 0x6b, 0x7b,
+		},
+		.ecb = {
+			0xbd, 0x33, 0x4f, 0x1d, 0x6e, 0x45, 0xf2, 0x5f,
+			0xf7, 0x12, 0xa2, 0x14, 0x57, 0x1f, 0xa5, 0xcc,
+		},
+		.cbc = {
+			0x4f, 0x02, 0x1d, 0xb2, 0x43, 0xbc, 0x63, 0x3d,
+			0x71, 0x78, 0x18, 0x3a, 0x9f, 0xa0, 0x71, 0xe8,
+		},
+	}, {
+		.key_size = 256,
+		.key = {
+			0x60, 0x3d, 0xeb, 0x10, 0x15, 0xca, 0x71, 0xbe,
+			0x2b, 0x73, 0xae, 0xf0, 0x85, 0x7d, 0x77, 0x81,
+			0x1f, 0x35, 0x2c, 0x07, 0x3b, 0x61, 0x08, 0xd7,
+			0x2d, 0x98, 0x10, 0xa3, 0x09, 0x14, 0xdf, 0xf4,
+		},
+		.ecb = {
+			0xf3, 0xee, 0xd1, 0xbd, 0xb5, 0xd2, 0xa0, 0x3c,
+			0x06, 0x4b, 0x5a, 0x7e, 0x3d, 0xb1, 0x81, 0xf8,
+		},
+		.cbc = {
+			0xf5, 0x8c, 0x4c, 0x04, 0xd6, 0xe5, 0xf1, 0xba,
+			0x77, 0x9e, 0xab, 0xfb, 0x5f, 0x7b, 0xfb, 0xd6,
+		},
+	},
+};
+
+static int dm_test_aes_key_sizes(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 key[AES256_KEY_LENGTH];
+	u8 input[AES_BLOCK_LENGTH];
+	u8 iv[AES_BLOCK_LENGTH];
+	u8 buf[AES_BLOCK_LENGTH];
+	int i, ret;
+
+	ut_assertok(uclass_first_device_err(UCLASS_AES, &dev));
+
+	for (i = 0; i < ARRAY_SIZE(aes_test_vectors); i++) {
+		const struct aes_test_vector *vector = &aes_test_vectors[i];
+
+		memcpy(key, vector->key, vector->key_size / 8);
+		memcpy(input, aes_test_plaintext, sizeof(input));
+		memcpy(iv, aes_test_iv, sizeof(iv));
+		ut_assertok(dm_aes_select_key_slot(dev, vector->key_size, 0));
+		ret = dm_aes_set_key_for_key_slot(dev, vector->key_size, key, 0);
+		ut_assertok(ret);
+
+		ut_assertok(dm_aes_ecb_encrypt(dev, input, buf, 1));
+		ut_asserteq_mem(vector->ecb, buf, sizeof(buf));
+		ut_assertok(dm_aes_ecb_decrypt(dev, buf, buf, 1));
+		ut_asserteq_mem(aes_test_plaintext, buf, sizeof(buf));
+
+		ut_assertok(dm_aes_cbc_encrypt(dev, iv, input, buf, 1));
+		ut_asserteq_mem(vector->cbc, buf, sizeof(buf));
+		ut_assertok(dm_aes_cbc_decrypt(dev, iv, buf, buf, 1));
+		ut_asserteq_mem(aes_test_plaintext, buf, sizeof(buf));
+	}
+
+	ut_asserteq(-EINVAL, dm_aes_select_key_slot(dev, 64, 0));
+	ret = dm_aes_set_key_for_key_slot(dev, 64, key, 0);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_aes_key_sizes, UTF_SCAN_FDT);

-- 
2.53.0

