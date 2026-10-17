Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E15CCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FA0840A14;
	Sat, 17 Oct 2026 04:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cg9bZUjM66ZN; Sat, 17 Oct 2026 04:36:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FF73409E5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211809;
	b=TfJwhHq7phFDROKaq7yJv6Bwv4SeGN3d3UY1hIZhRexyu1SuE/1oWHv6DdeZhU7D/69x
	 ucL2ENv0dZgUHMz7l9hWwxp4u8XMyz6syP49ys9l5yicbzyJbjjoj5dqKO6gsdwEkUNzr
	 o+tDoEkegCqpR/9Ao0csP8NGqHItWRT8jSvGItiXkAi352+ZJjB7ZOwr6T17PH0kzMfaE
	 vzWJ+9dJiIh/8UP21vwQXynSBPWc3D/sdTYrs5bhC/xg45OMYVWMrynBAX9q3n55+fPrv
	 iXz1wOfjkS1YHUSF0SMTBmp5Y8+kcWiROIKgFAVYVjymM7OP0cMEuUit4+5IqNvkNhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
	b=JLR39q5sy2wXzO24oL8AJpwfPjIfSLjAwHm2iNvY6q9dZt/jNC+m3f3hAiek2kxSm5cL
	 4h5QyEKvjIduL9xUZUDPWZYZ9kUXUlvndmS3dy9ngQ7KmbMzsm+SYZYqdjIB7+moW8ZvX
	 DUIvpLH1vY+gTpN+IHBn7dk9MhgtKr2OJhmvSk//deknRxhSY3SRom8tmGkSP3PArZi6C
	 7X6omJhsvSpyuzqyZa2gK1HjEo9jlOxzRNuFppzF+p6RPAfFWljdEe/sV+SHsrgJgU9RZ
	 fzr/En18JLctX88lc9HVGY5yF7YNwxoi/77MTixnXOOljR5TtgOOYkoqHjhoxbkYXtA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211809;
	bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AwT8A+u5ZsrjSYlgKso88M/GjGGKDQ50f2ovD5vX4BOhPxvJQxTfersU5E4Zh9A0i
	 00aOt7cQDfeTXUv+6itJ/4dpPNEf2tbE2QKcDTh71oYhaYfpo45Xxxi4PV4QpIst6N
	 8PFks+PgJe9ygn5CxPl9aqoD2mt0nCb13K01B0KpbSECah+gOgwOF7eZHHpz66HV2J
	 egpGKU2kXKauOkDuE68ADIQkNmk57Zx1W+EqrIlatl8BDZEFkd4Bz0m42YVUBzgYYn
	 XuzAnx3AbwB8Z3qh3tTaU6y/oDb6PwjiLtCTys56qTz+5xJEl9g5WhJeJbApggzvC/
	 e0tO4RQH5jmnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FF73409E5;
	Sat, 17 Oct 2026 04:36:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 528917AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44D31408BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O0PDxg88_AJk for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 81F2E4022A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197378;
 b=fEJ2iCRCCnnDBQdyt56F1F2hfvG7t+kQzndmkCBBwMJFYha2pKeaYGGbSeNhqmStCcr9
 rwNmwOvQyk2Q99JyU8jvEU0B9e5lb+gynw1U10pCwqhoT4lyk5Ee7poDfuJwth93QZCnj
 XPtDNRz98wSHv9LS668RpFaxGXudT5uoRFsEEa+xOZ5w6Z7jADaM7S9StDFqGhCVWK6wd
 u2KReZkXXurMsNEPA1f6P/ysWRWUk5QXrlXg6xQpUdp+1GbPESHbtCtwExxTJeQgGM4rU
 k2oU5M5DYL2l3c6uU8o9RbGb1hywER19AAPUGcr1XKKNyVUL8YAkqtoJisR9yHijM3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197378;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=Pq7mmHimifsvcjn2uyyY0AqxTQS5MsmYE8rGCbO52IVc1PuwIipR/09BuqQzpmbblJLQ
 vwwq9bL9kUv8656fe8E1vIbW5Wsbm1fKloBlkkpzpWdTMWd0gFI9zJVmi8Lb++tLZNNfh
 LOnCHJtNNoVdnQnHo1vuscv1yphxliL8+oxMKSjqOYaMmwjGScSGLXdsMsQ31MrEGouX4
 mwHEYfycHda+/eA5CvQY9BHxNRoTF0jYwAfnfrviwQ/n2U0EZv7Ao3Ex62EqebqYvllWR
 fu00CQnve478fiPTrI0eZDSlmyVmizZUHKSu1GZs8FbheJF9w1HY/qMtDwuU7RN8Pig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QJHXyC1U; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=QJHXyC1U
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81F2E4022A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:18 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-53c156ba662so331246b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197377; x=1792802177;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=QJHXyC1USRFX0VHUWjq5/bZq2F+2LKbU88QH9PDO1nLnKCwLzdtER89veB2im3QGgd
 sRQ7R7xJ9qaoXotPqEdEAkRaWUYfr7VCR2+vsVOP1J0gpP+8zIszUEWCcthvycBXfDCx
 l6OMKTM5hA91RFXTdQ3Wx/JE8R5ywmgGdeuS5o0Di4NC8nIpEzT68jkQPLUEoe3EGyA3
 iHOxzDWcvhnZ32WV6iS5RKvw2ttqEjXbEA2Q7/WB/yy+F5Q6ykrzthNEmlgVkN3Q5/lZ
 qfK41HAELJv8qyqiuPr4BeKC9gsyVjaPeRHihHN58i5PfOYC4oQSdxNKhumxApYmYdVZ
 wuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197377; x=1792802177;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7Q3E5koZI/qBjSbZlBOEVkl/RbDviEV4YXV6llWwXM=;
 b=QYmIhpNAyMwilCUgSVwwxNvc7mII969Z+4opltXQLkbTZf45rqB8M73BmhwS2JgFIq
 W4nTA5nDzzuAoTuMbRHCVtFwyvgZg8tM30MotoECEC21jMxj8DKT6BkG7USQK1THm1H8
 x3V4fUWg54e5sD0m9JB00LNdZnclH0YcUckajGjfZnEOQxgVPt1sd4/RWettyzYOoaGZ
 mc+garUH8BTPu3i2HssOcO0E/q44CM8sHZ/3OE3Cug/s6rK6W83+HPfw9Gbo3C8qQj7f
 gnsmU0KdkFkP8gkUIxifS2YxDgMkNkRzUJtX9+dFUc6n0SrRrVX+APtdHurz4WJDdjdn
 89iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxho1PHxkSWN8hH4yRBQr3YH+dT96YEamIwaJ7A7MUKrbAqswp64qziGp8T8LO/gpd0zU++baM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJOZI+0cktQ/sgQYROQGiXWN8QERqx995OwfCCShD7ccn/0mrUS
 euhylueAFDsU3S91Zm5pH2C/55JQ+cCRArUdMX7hhAYGBjJWV8iK1zHi
X-Gm-Gg: AYBFou1uTLwb2No7wpzZjQ6wp5v3ULhyhrJiY8pV3g3C9w/BZ7DCWSBLX79bjchXBuW
 UWDHvwSlV+ze/Am8ZgqvWdSAC4Bpim5RViWJFkB19niDwELaQm/EicI0XqYcqpwdeKtywBUGiDE
 +Dz8rDHyhD3SAEgD3I4/6cGcRdxWTTbyVqqW5RQkeNzHXwCXp312k3IkD0QrgKC+DRY9fMhfrPH
 kWeFXdzOuFm9n1P9ehZ53vGw3+lIQFKFtsm0oa93bI/9GJ3dVjzdKR2c8jzb/ZIR4jePpvd6zXE
 5onhllfQZwWWy0tEzI6tZn4UgDVi4UvH/UJwZkfyUKRLJX6VOeDU5oDgERGPu8aLUoMpuW02419
 ekS4g+rAtJ0bpwBTck2yWaLXQkGhqoyxgpoG485pwPAWeaTXCLjEFJHLLSnasUnIfYWLgVAL7JA
 sAS7JLj1ZBckzNHsuVo2EQzrWplx1OhdWYuXi5RzMIQasd2mbg7B9laPdsoGsGDwWXG3MtMbjtR
 3TLFpY9359zgBCDONf0SLDw1anJoCFkOnZAFOWc47MR6gbln5Bj+aYa3aixsqruWplIQEtKpHLN
 NfToCjyfLiFm+wdlyIcX7VtET38kGXhMle5835L2KoBR1p/JtuTIuIOn6NuJ/naDXABHHUT06te
 klnUdldZSWwb64UPGQ/m0gQ==
X-Received: by 2002:a05:6808:660c:b0:4b3:7b31:8df7 with SMTP id
 5614622812f47-53cd1cb069bmr1291755b6e.14.1792197377070; 
 Fri, 16 Oct 2026 17:36:17 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:27 -0600
Subject: [PATCH v9 13/17] clk: sunxi: add H6/H616 CE gates and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-13-c24e64daafe9@gmail.com>
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

The H6 and H616 devicetrees describe the Crypto Engine with module, bus
and MBUS clocks plus a bus reset. Add the corresponding gate and reset
entries so drivers can enable the CE through the normal clock and reset
uclasses in U-Boot proper.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Add Simon's Reviewed-by tag
---
 drivers/clk/sunxi/clk_h6.c   | 5 +++++
 drivers/clk/sunxi/clk_h616.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/sunxi/clk_h6.c b/drivers/clk/sunxi/clk_h6.c
index 81deb5728e5..27ed5705a14 100644
--- a/drivers/clk/sunxi/clk_h6.c
+++ b/drivers/clk/sunxi/clk_h6.c
@@ -20,6 +20,10 @@ static struct ccu_clk_gate h6_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_CE]		= GATE(0x680, BIT(31)),
+	[CLK_BUS_CE]		= GATE(0x68c, BIT(0)),
+
+	[CLK_MBUS_CE]		= GATE(0x804, BIT(2)),
 	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
 
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
@@ -77,6 +81,7 @@ static struct ccu_clk_gate h6_gates[] = {
 
 static struct ccu_reset h6_resets[] = {
 	[RST_BUS_DE]		= RESET(0x60c, BIT(16)),
+	[RST_BUS_CE]		= RESET(0x68c, BIT(16)),
 	[RST_BUS_NAND]		= RESET(0x82c, BIT(16)),
 
 	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),
diff --git a/drivers/clk/sunxi/clk_h616.c b/drivers/clk/sunxi/clk_h616.c
index 3e7eea25bfe..d5b659d0bb2 100644
--- a/drivers/clk/sunxi/clk_h616.c
+++ b/drivers/clk/sunxi/clk_h616.c
@@ -19,6 +19,10 @@ static struct ccu_clk_gate h616_gates[] = {
 	[CLK_DE]		= GATE(0x600, BIT(31)),
 	[CLK_BUS_DE]		= GATE(0x60c, BIT(0)),
 
+	[CLK_CE]		= GATE(0x680, BIT(31)),
+	[CLK_BUS_CE]		= GATE(0x68c, BIT(0)),
+
+	[CLK_MBUS_CE]		= GATE(0x804, BIT(2)),
 	[CLK_MBUS_NAND]		= GATE(0x804, BIT(5)),
 
 	[CLK_NAND0]		= GATE(0x810, BIT(31)),
@@ -86,6 +90,7 @@ static struct ccu_clk_gate h616_gates[] = {
 
 static struct ccu_reset h616_resets[] = {
 	[RST_BUS_DE]		= RESET(0x60c, BIT(16)),
+	[RST_BUS_CE]		= RESET(0x68c, BIT(16)),
 	[RST_BUS_NAND]		= RESET(0x82c, BIT(16)),
 
 	[RST_BUS_MMC0]		= RESET(0x84c, BIT(16)),

-- 
2.53.0

