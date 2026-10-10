Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA02CA9EC5
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44D5D810E3;
	Sat, 10 Oct 2026 22:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZw2Jrvfqw76; Sat, 10 Oct 2026 22:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C6F280C34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671548;
	b=py5mneIpUj28PURSJAGLgGRj/aa8xsxN27YOYBhPCkH5XLi/Ms1VAbWBNeHJuAy9wj5D
	 V+orOKWjnBgic3Ax28HpMxJdTFUYQV2GuodjzlMCZRduIwWFEOI3LIzoPzT3ozi8iTAzi
	 nnmsPEV5sfJ+UoRXSmi69+J7O1L7TMltWfMmKjngPX2MVK99xVQklaEGWTtH3gVSCWv9v
	 5wQshbsf3tpvZcC9hoyTk6R3p8VXYhQ2a0p5Q1REzlpp0QrZUH/PjPZ0+LriFQ3PUiR+2
	 qW85i/Vqmdq9X3wKQKbGG+HU66oZKOtRGKfUcKWndAU58c79YT8MvFoU6zXDIXQX0kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=fNHAbVq7jTBjtgqSZDGvzU4s14XKcDgPkB7mVzeHYMw=;
	b=kQf5hngTY+k0b/Netauv++gONyIxCZZuG0/tSBXxsXyc2EFAOCi24Row2h56k8YuIE/N
	 ZvTu5rboaDz3ukKWhxUNolH9w0jhkS2d5qgtkuZIy7Joy085VQeARQrozFJe3Hn40If8H
	 /IHKRl+f6Fb+mqH7tfmQkqM/dxcB0x1M1pwQIaFa+202D4GoXm//oBGQoLaeVwf79ZkLx
	 zmRT7Kqysh/E0HCenPnvr1bMOFpKRJ60fxWpb7WUhBwQc/XhvP9d8A295wGldlzWrFtfT
	 mAD5RZKRrIgXYcV9p5eQwE3b8X5FjjlbFjjKQjAfzHnUvYrhOaac2rx7rQYGh3wEUnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671548;
	bh=fNHAbVq7jTBjtgqSZDGvzU4s14XKcDgPkB7mVzeHYMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OMDsM3gaPholuOKFH+Pabfec/SyQRgAi38RwOc4DpuhpW7vJDkALhXM9L/fw0ly9s
	 Q/WLA11tU2q0nQwvV2w//vfA3GnQlR5s5MfeE5Oj0ff4WNP03kOXoc9AKYBJ/ayByz
	 aUW8ZVhXEsH4G+i8LZCrqfpLT4OZz4SJx9ulgWxpfzoRqfgmSGzlVfIpF1TlZ1z6o/
	 2FcMCPwRJ30ffPiLHO86IOZuPTbDacu+mdlaGCBfrHYKDlPcRNuYhDIhel7SjZrwdI
	 dDH3B3JnmgK88flXWpcwQJmWljSX6Bd49hV5KgL7cq4wfNNBGaVITSJMc6oElq/3uv
	 DCarf6aXM7Vww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C6F280C34;
	Sat, 10 Oct 2026 22:32:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8891A356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F1EE4005A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wK3HowI79bHz for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C73C440068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666489;
 b=isSSAVcTl6jGU/iH6Aql9swSLsMxM3tNQaha1+AevEIFIZxoDfIdsJAKNBTEODb6uXDY
 wn0r4vPb89GMw6DQPBfJ1YQdifTxofmfSyms5Y4KBPqYiPavOaB8WUT6yqLbs4i2CVKxn
 UVij1uZs3Y+Q+yMS+d11uBYCl0vztK39P7tREEQ9B9dbrXUy98N0mm5SOhY+mpdUa5N7w
 srj8YfApMV+itVb71bF98dxqgakqwNxZDcHV8EaIdG2sOI+c5y57lyZH46UOhFpgj3D/1
 xc5LsacsbTMjXkDNEX99BGQxSneTXobC0V42z5RKMJGZg3r0ZjIgg6K/bL6DFc/Gdvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666489;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=fNHAbVq7jTBjtgqSZDGvzU4s14XKcDgPkB7mVzeHYMw=;
 b=iriyAZR+TGwiEUuEDTPDkYwzcBqZ7bi6HX9I+ImZbuzGtqdR5cKZ+DGjxII3ASgJ4Ror
 QjASEaB2Y/cAYtbRDJ9gklVjTakYzE02Ko2w9BABu4sbs1HYEeKuf88R2QiKv/aE2E5al
 0AWsoJWb8tW+86Mb0p/4xCl7KHh8msXUCpfW23QgZ6D1ic6hg0YAoqxjnuYiNKHLXgUan
 q/CUsFQeZFRaZXSOZHxzRWFe/6O2d1O+lqF7pa6dMukJU7zmwsEpdNHrIWEnzAeRgccMT
 ZkrY/aeiLN64KY3XhI9AzWKMX+BWqpHwOaux0xNnrGHzdpM+4t6EPyJzfFoDK+9Ezyw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HH6kXnpx; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=HH6kXnpx
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C73C440068
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A523144506;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 888DCC2BCFD;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=qfIPi+Ou0jyqHnjH/NxlIZlvFxJZrwgxs+6Gpbo88tc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HH6kXnpxQStba14sgPwmElRx0kKann3KdzDUYUXTI2zEiKba+f9IKOkEAo682smEn
 al+7fG9QIN5Urk0ckLhMMF4PsZtjahiUR9Z/mPEpp4S7RoxltKfqDISMJAfb/5s8eB
 eR7D18nQ0km0z42sXbYAGLaMroayvi/OcuqcUxnsdWQexPUytE9BdU3fDbHq/BQg+d
 17vxxrBVVgdd4eRhpIh/NkdWoZ5vpxPMx2Z/JG2DPI+Wfmi/u8eDlMs+02R98Onug6
 ivxOeF1PUfsa64G5BaBV/73Uj7fShhdyI6cJMq00TwDHBjNVYKC72dcM8UnO2kgjFj
 mu7evC8syUAsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 78F09CA9EC5;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:57 +0200
Subject: [PATCH 09/11] usb: gadget: f_acm: check the acm_stdio_puts()
 against an unstarted device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-9-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=712;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=JyCzEoNpBtsiWXoxzkm+I2ie19oOjjjfAo3JE5XeouA=;
 b=ieZmjf8fuIxZ7RzEB5h+IN70bGr9btiLhKA5J0mESVMXmM75st7Ul94/ul7vsukBSiip/4FI/
 xvOI3lezkaFArs74Cp+PtmV2sD6Dchqwu9tLy+qH4XmjXQ681aN7axJ
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

dev->priv (the f_acm struct) is only allocated by acm_stdio_start()
so prevent acm_stdio_puts() to dereferenced it unconditionally.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/usb/gadget/f_acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index b6c11d97a62..b661ef4b0cf 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -612,6 +612,9 @@ static void acm_stdio_puts(struct stdio_dev *dev, const char *str)
 {
 	struct f_acm *f_acm = stdio_to_acm(dev);
 
+	if (!f_acm)
+		return;
+
 	while (*str) {
 		if (*str == '\n')
 			buf_push(&f_acm->tx_buf, "\r", 1);

-- 
2.55.0


