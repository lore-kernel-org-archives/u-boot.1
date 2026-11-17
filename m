Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270B606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nCS9rDAv;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=QBTj8v+e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C48A6087B;
	Tue, 17 Nov 2026 09:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rs4CEGQMG9D9; Tue, 17 Nov 2026 09:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67B656084A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907201;
	b=B/OQMwb4KbJQt0uKLTlzL25qilXU8CAj7Ss94SrmgPc3blNIT53lO7/QlpiRq5YMkh6P
	 S69HvbS2NBOTQerduywaR78pWhYD1jinUwNFPd3dyiBy3nDwbMKW1wCYdY3GGmF5JD1FW
	 uOhPX+iWspuuCnAaYu5HFJ5JrOETFOTCsxlhqQf5YbDFTLIOaMlgmHdUpQlukE2KtR6LA
	 3HkKL31yCWGb3B5oH4dT1fCkydtiCLvT+G8muR3ImnValZymz9IwYXvY97Spnx8uqMS1j
	 +MsjYABItuyuqi7ZfYbXwvITCRRZCOZgRolLVRO3tOsRtp7ZGy3mytfd7HxMb8H58Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5ZNjdOJLgP3F55oDtm+bCc2AwJp13lqk8hGu49W7vVg=;
	b=La54BmCCfgeCl5kgjvx8DrjSfPB9F3ttM6zF1a7QDcwVf29VH2mSw6CxNbrGJCkAA1Mf
	 aFDsNdVFY7f+8X+UJpH54qfzsfF8CqQ4sHNSFdoL0/Ferj3aL4KTA73y5lh3a1B1u+0pM
	 viFs4Fs7h+ejNlMaZv0idSTEt93CjclgAQ2zDcbc99RXulJQZBcg9cLA/YxuyhrcGKI4t
	 UtNTDEr/gqiWynHTqBqjB4zac4EJsZgq8wQTXRHMwgOTOxzvBYAPi6qfHm1bNBnwAEriI
	 7FNRO8dII+SLJTfSE74lKZArT6YoY+0+Cy6ccvZgGrOQO1Iw5zwC4KQ4pcyyYb767Mw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907201;
	bh=5ZNjdOJLgP3F55oDtm+bCc2AwJp13lqk8hGu49W7vVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCS9rDAvhmOmnF+a0Xe9YKECX8jKNOo7PQINReq9SxoDGUpc9z6Y2slMwHJVunzRK
	 dvKm3L2o9mWW/g/UF8DTBxrdA+Z6f7bJiehKTVhIIAE9Vb79vk9HlfSYbH7qpMyoZm
	 oPBD/Pq8jQE10jQSYasnNw5NFJQ9VeTNGIADBvdWEm3sM2CI2nCbRAT5CuL5kp/YDz
	 gTub3yK7urMwr+gTJJn1xVn9QhfgZgSgWXfRUkd4Tl1fwoU0IO/elicIiF56DMiw1+
	 ZhM+MxAQSz6fRAjHCWe5V9ddRzyGuUjAKAuFsWh6UyVv+UYjiVmcXH3+7n5TwdHtO1
	 VGi1qh+mUjRTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67B656084A;
	Tue, 17 Nov 2026 09:20:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 424E7A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34732400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJ2ZCOTWk8Jo for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62C72400BC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.125.25.14
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.14;
 helo=smtp-190e.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=QBTj8v+e
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62C72400BC
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:48 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1s48nVz1MG;
 Tue, 17 Nov 2026 10:19:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907185;
 bh=5ZNjdOJLgP3F55oDtm+bCc2AwJp13lqk8hGu49W7vVg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QBTj8v+ew0DhvE+j6a7OQ4fcuPSaad62jB6kl1xNkmlQiB/C5ZdK+m2Q7qGZKjwCX
 d8ffKMea275NAxWrMXbgkuEaEThHGnXQlr4L7YaZ3V2A1K1HwB6ZinnZZ6TggcAcbG
 ZMOev4zIwCuJwPK/e1QA7lxlKEkNZQRoqKB1R7rjx3SS1pGgWslljWXQ1j25mIn1YA
 MQISzy4KL4Vx0bjDx5llpASp1D8etBDEPXtvHpCKTMll+Gmk1L+VTIRdYbVIs+LmR9
 o1XPREKclcWNK4IALRuhAnP1lx9f11JMfEvh2oZTOakXIcAXcBV/hCHqOHL0k6+76S
 P1AcNFFWdXb7Q==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1q66kKzgj3; Tue, 17 Nov 2026 10:19:43 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:12 +0100
Subject: [PATCH next 10/10] doc: rockchip: sync
 [ST]PL_ROCKCHIP_BACK_TO_BROM help text with Back to BootROM section
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-10-2cc0910f9455@cherry.de>
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Synchronize the explanation between the Kconfig symbols and the
documentation. Specify which Kconfig symbol must be enabled for the Back
to BootROM logic to be triggered.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/rockchip/rockchip.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 41c8defd6888..424655ab40e0 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -585,10 +585,10 @@ Boot flow
 Back to BootROM
 ^^^^^^^^^^^^^^^
 
-Rockchip SoCs have the ability to load a second loader binary.
-If enabled, the TPL/SPL code will return to the BootROM, which will then
-load and execute a SPL or U-Boot binary.
-
+On Rockchip platforms, user code can return control to BootROM which will load
+and execute the next binary in an image. If TPL_ROCKCHIP_BACK_TO_BROM (or
+SPL_ROCKCHIP_BACK_TO_BROM) is enabled, the TPL (or SPL) will return to the
+BootROM after it's finished executing.
 
 .. Jagan Teki <jagan@amarulasolutions.com>
 .. Wednesday 28 October 2020 06:47:26 PM IST

-- 
2.56.1

