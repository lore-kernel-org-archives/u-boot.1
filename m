Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95A606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZULH0/Ps;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=G1VkPD4Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D11581125;
	Tue, 20 Oct 2026 17:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9gJMm8ZnE-d; Tue, 20 Oct 2026 17:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A7C881168
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517200;
	b=dUmdhsgYapxtE9/fZIrcxLc3EEUgQRMde1k6qFQjZoJk3t2W3/18jTk3GsxKomb3ZBGe
	 Oj5ADZ1wUgE96CpV31jKfXB4wfMdE3L71lJG0qtm5vfrM3vDU9/OJoInGKSjbLzwp5Bj5
	 h3bSwiq8ObTurYs2vD7dDTIjha/pF7q0g5M3y3brcV1a6cDWB4Yo5WAQlfv8D3ttS9kW2
	 j82+zRv3n6c9t4ZBNMOLDRkgS2YQ/1qjWWszeYTDvvgzjUBXYvAMEslJhijRnrWNgyeLU
	 NIoeLOVPRUIEq6JblG9m61tAwlDeQxhECX2fbaLPkeHadVbx7sHzo6d9qm+CBEADUgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8vu6mCxagrI+yeKoTg4z+XptzlgVRZNPzA0VnnIlvAo=;
	b=mxxinMyMovM+nCwg7SgsKLO873nxzvOXs/NNh5qoTHhft5UJRQkkI7BNkcOL2oe5x6NQ
	 TY/emQFpHGpwZURd0KHmkA4v5f8ZSZF7lZISh9w1mGQtvMph4Y1ScK0gXQQoDQ1aXFF7T
	 dbp/8Ze9Gb3FBzfDOXeRDOhDsOYK6LHE/5G+/9IQKOp3UjlAaG4svknzdprWqtNFtoEQE
	 O7zOKXw3Kt5/VyJmrDFnlIXxe2qK1zut4voTRPI5lZGU0voEWoBf+LlXHV2/5GIp8MZoU
	 FpbVbMPLQRIiml9eDevx6nkMrdFzcmA6RxNQ1ZTjBg2rm/WytoJQw/sCI1cRZuIVPMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=G1VkPD4Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517200;
	bh=8vu6mCxagrI+yeKoTg4z+XptzlgVRZNPzA0VnnIlvAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZULH0/PsCLMwDROfTw24a/94kG5WnGMGC0YtDmG8oMtEWF5Tf7yP/Qg9vrPfwvUN6
	 a1qiskSggBh0X1ccLGuOZ1loA5KV885h80OEe2F2YMBvzJhHOyF0UJae564Gn7waLe
	 NrEQEYuPKzs3Nz6fyLxUmY3pixt1mJUVVcUAJvwKiVA1ROBiTAtnbqL7D2eb3xq/sQ
	 +bpvQnxMyG9mjQvP11AuZ/G3SI2kYMQrFTOMDg/PYD1sLmmpWTJjfp4E8YUjk2erDV
	 KqJ0zHBjeG7sNDsntNyOCcM7sNiMcksXNh84V4LsWtWsTb1Q28sNpYY/njEOIUT4zz
	 TBoGdYjNERjfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A7C881168;
	Tue, 20 Oct 2026 17:26:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EE891E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14B1D810FE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExdUfIUguDJY for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CF53810FB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514617;
 b=mGkzPdn2pAo682NWFL8lJT5pi6er5ljnp9TAPA+HaBtuXSEAoN+U0JsnEwsJkUvKPRMw
 xLDvxxWJCF85K8fdIpbBqMTRDxue/chGmIIih77/GcZ08xj525MHHFE3jvrRfd3l5gJIC
 Jjq3hQbHjHo/bdXhKlswQKgM7ImODtyCQ6bgzL7Rm7x70RYyxjy4ogUDrNU33xNRDC2ru
 5+0jeVsLQanEdObHkbaFhw2Pdq/WJuhARvPC8MqTKkNd+eDia4RCUSaLqrcgNVlyFZ83A
 a1MufGRoYD/fkMIv2vz6mbRlu0iNFZDxueuu6+ciCWPs0Qja0zm+tUvkrc+hUixdrgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514617;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=8vu6mCxagrI+yeKoTg4z+XptzlgVRZNPzA0VnnIlvAo=;
 b=VP6TDulJ1u/9h22QsifB9dEj3SFTjycY+cwlSl9V6/yCZa4hmZ9le0uAKu3q2REt/xZr
 vePSx/3sPB8wjD22Cpv35lBxO5NBzmQIwDairIENEnvmEACCGYndu3bDy8kRiqUUBDUJM
 suFeKczJf4/prjLAHD+JKfDbHxna1MysIjBP6LxE7mdZmoKhoj91GToJVP6P2iWZS/oVg
 6B9T62NIr1UGp/AyDVXZymLciJoIAOWdKa1W+/FveXJzZFb/gFUpr5deZjR6stJXySv4Y
 p2WMX40xiGlcRldd/ncZ016Xw0UARvnTwhfAu8Onl6YWpqDq5fzuWO5RFnK5U0jWImQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=G1VkPD4Y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=G1VkPD4Y
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CF53810FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:36 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4956869750eso27450815e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514615; x=1793119415;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8vu6mCxagrI+yeKoTg4z+XptzlgVRZNPzA0VnnIlvAo=;
 b=G1VkPD4YvdebFgVu/VHLX00d6ROmgbZaYejg/xMb1JTUEDBI4ZSU+1TETP4CZvv6pA
 lLWUR0cBGX2Alp84Ej/zsf8aD1pKWDelJa2Wt16K4NEQI8JaLmsr/6sGo7l9ofVmkWvx
 D04YHxJCpoSs5aPBCGLeQdcSnqUSL2ektg9Ja18bqptiXr0Xz+tb24il4dyzopgWLvDx
 6+Tm/EeUSZPvpORx4TBLcNxzSW8Ag2c6v/Oj/PDq5eoyS9V5hkk4sM2TGnby+0GPjtC0
 Oe9mnvZ2FKdxn3dhZfU0Bt6JUBm1rVRjTYkVuT13MuFm59u4DvcILoy+lkmvUsMAth1/
 ma9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514615; x=1793119415;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8vu6mCxagrI+yeKoTg4z+XptzlgVRZNPzA0VnnIlvAo=;
 b=u80CeR5scL2Fl3P9HJG+MHQZC065I8YHOam0wE0CiZelqsSEywAWqGEkId9Y1pm+jW
 YvI2otapfHkzOfDmCLcMBuDn/B3hUxWHnVwfGBSYVaXTc8mEbzj0IRicOzpHU+Wpshho
 89isUIK+MTh1v3FE3xMLWy3lk+XJWHgMCk2Wc4q+KsoFimFGEgD+MFa9cATTEpO9Yqfx
 XzLePATJ52lPFQG9TREiiavykYEZtEU8Owa0SkHZtWAXQ6aUdzucBEISLlMGRyvvSv/W
 LpNUpT1uYA4HaSi/G4Uoel64OIJo3TPSxJjxE3pEHENsbSYmjg16Csn0XN5YTXG/cEhq
 bizA==
X-Gm-Message-State: AFq9FYIoDbLC9UGMJACDkdHO7MaTPjljbnWFtYa9OJzBUI/vWfabz2NY
 2YaSAAhP8JkYNHrTAeqnD9679QM4N6sjbO+So2bC+nKAZh/IIY7V6Hofy6B57tMAluM=
X-Gm-Gg: AYBFou2rjAefG26J0R9Pd4o0z4PITJIMCAPZ9MsFNji0CdHf9IyV1+2eYa/27Tww53d
 owlK6Ex2IAV+NLZLIhPI8TbTf5zhXsvMpJgplwtTpzb8PhgvkGMoSYTXzJ9gbDzmVs+8ywZ3KJg
 AMIZNhNAw5pk7rJKH9mFtbFwNfC649wrxelyCiuwnkHvjsT88V6yn6QaMvXkWB9PUujaKQFqAek
 BhuyATfhJ+aOWJ70/ixpIRZtKfg5MDa6P3OJRQTUydhvJhLbYrfHWmmzmS68eXeVx3pWpRzxmzI
 Jr7+QUPan0ULNiEU+3iYV2wz9BhzJtUm1Ha3NgWbvN6bOl6AzMOLUxNjbsiSE5mde9jTXCWr9G3
 SQD0z8dmwl9I/UuoUGXRjY/8X8cB432JOntAmBXD9zNejuzmfxiIbRBqufSYf5BY9d4alMcRVil
 VC0v2dGGNFjj2dF2tSN8lpX2GDmtCL1xx9H501d92xaL8bdD+zOGOA3i9l7CdTjAzsWZKjUZ+ky
 15mBO7YRlk4OVg2wW/w7vjwt7T5WFMS4ZO3q6LzM5J3LDilTDnCmg==
X-Received: by 2002:a05:600c:5492:b0:4a1:d992:9476 with SMTP id
 5b1f17b1804b1-4a1d992951cmr237460745e9.23.1792514614635; 
 Tue, 20 Oct 2026 09:43:34 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:43:34 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:09 +0400
Subject: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=alchark@flipper.net;
 h=from:subject:message-id; bh=taFvqV3biXxuerXl23nJIx8i3OAb2t+XHEF8C9F7C1I=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7m679XraAOxjpii/mTVi7yG9XXfH/hlt72YxPVgr
 Ub2+S/bOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqnlkM/z1al57NEtFcPLk7Pu0AQxU7a/9q3XezPc6dfm63plx7dwEjwwqPkw0
 31A/yJSVuzn5evV1169NuUefCAGGr1U9FAuKr2AA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No in-tree board picks a compression for U-Boot proper, so CI never
builds the compressed path of the Rockchip FIT, nor links zstd into an
arm64 SPL.

Turn it on for the generic RK3576 image, at the highest level, which
shrinks the payload from 690KB to 296KB. The image is meant to boot from
whatever medium the board has, so this suits it, and its SPL heap and
SYS_LOAD_ADDR already leave the decompressor room to work.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/generic-rk3576_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
index 5e25653820c2..dec4364876b6 100644
--- a/configs/generic-rk3576_defconfig
+++ b/configs/generic-rk3576_defconfig
@@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_BOOTMETH_VBE is not set
+CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=y
+CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=19
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000

-- 
2.55.0

