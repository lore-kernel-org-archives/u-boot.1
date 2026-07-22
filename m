Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F50FC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13F5080F63;
	Wed, 22 Jul 2026 20:43:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id amlpR34rqx6f; Wed, 22 Jul 2026 20:43:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8021B80F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784753018;
	bh=PryxGpCcqJEgrr38fnTBBkTcWI0Mg1rz0bKnWPWJ198=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IWoKAAkKYvEEtI928lW3Xrnf08uQWJkRn5hkwb7j4vDZILdbZM9JaGktMwyw/fjTu
	 HxiPtbYQnf1QYgsZKwXEceGf2/KEgJFLVsgXQR9XzfJ/1MHw3IFjCsAEjmxvwEdmiD
	 9M3TCd/cLynP9ygdD2eVGnIT27RIHhJrI1Q9AFQXSMrL5LVdaPFG1ibDmG7POnR0YL
	 tTI0qRDKeBT+GH/2PpasaaUm3PWUWxXzTtQRvP5juThfqXnCmP2ftTGqojvqux1KXx
	 hwAEpo+zUqe0IfDlvughELgTSbo2h3ez4pbeKGjXDTx59Vgg9CQskrOJOI59AcB60D
	 43j0Be/6ewNsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8021B80F53;
	Wed, 22 Jul 2026 20:43:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 096E8347
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E40576071E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlBs_89PI7Il for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:43:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 089C1605E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 089C1605E9
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 089C1605E9
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:33 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so38985695e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753012; x=1785357812;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PryxGpCcqJEgrr38fnTBBkTcWI0Mg1rz0bKnWPWJ198=;
 b=D9HdJ8Cg6Uu1U3zH97D0U7U+i/Dt2OOSyjUpHUtO1xvSnQZ1/uYf3nQCbIb7lLYAFs
 cpCm0vnSVimC9DQI24OMHfB9Rj6qHWFjlZ/xw1pFPzYPyyYDU/CvnY5/3Ptu5BDV9VTH
 C4yI1/C9GAYe97Yg3oPfR+5Ch05rlt+U3OYa8IPyoQ4YQIB0HPw+HusoBwNVvo/FKnfd
 zRBDWtnNvmXQ3EL2ox7j8nfPVJYdy3YhLMqcWrjoQ4AWT1XAliBwu5LPx6HbRdD1S7rn
 fKiXEyjSc/I7YduQhnyZ+i5IR3IF+/gMLJlfDcLdA2HENAKx5RQ6Y930eRWh7Nb8rCO4
 Sqkw==
X-Gm-Message-State: AOJu0YwsttlTsi7tvcaO1v3a6hZPVW55NW9V+oXYXgnR6N1dccVWkEgo
 /811jqPl81DQN7eIFK/TfSy85t401NFELEqLQha0sup4uR0qZrlEZIlmRMUBkcVzgPU=
X-Gm-Gg: AR+sD12C+Vs+5KSKJ6arjgctWU0yVcUWrRiNkR5ZGFgExZxm2TTs4wuoQSRHOPQFlSW
 KncRRMIlbrBFAUFhDH8/HYVnqZuXSyVRWItc4Pbv7YyqeV0vHefMmQNrmcX40MRI9ajsvGE84Th
 FlxQ2Qdm/gW34B+Gk1eVYEp7UeEqKdcRMzl1rRQPDWtOXHsx6hIsB9O5m2HF/JcQWG2Jx94dEED
 yUjQXNURGSAFwV/L2Wmtjwd12hyvR12Mh0OZe+ZLyg42bZ3ld+36amqL2+ezavw9aynBoB/TTO0
 ekH6lxoPfwOmWufXV9jP6zk7cxAjutsxVACJuwAFMwkb4Q4J7JJWtDZ64K8KpaoxhfLI31SZeC9
 /+5IgxK2B/xE5SWhjMlN/aav0j4ETdMJ2XRRMoY9nphRUJerTvMJF8wL/sgRHIIe5Z64a2aMiK+
 9JS0LrZ9o1m64cTIF6ARfoqm2fmlJQVNDDlnIijSPqKotjKhsH3008Ogx06qJ4X0oMtdZR9Q==
X-Received: by 2002:a05:600c:1393:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-49573c8c2b2mr2772755e9.1.1784753011909; 
 Wed, 22 Jul 2026 13:43:31 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b4e8885sm60775195e9.0.2026.07.22.13.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:43:31 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:43:04 +0200
Subject: [PATCH RFC v2 2/5] fastboot: use the common handler for USB reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-spl-fastboot-v2-2-2ba3f71c42bc@baylibre.com>
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784753012; x=1785357812;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PryxGpCcqJEgrr38fnTBBkTcWI0Mg1rz0bKnWPWJ198=;
 b=ommqHBkbwfne3mc1oqjQhKJPRfEnTy6oABfHsemj4Wg8WI52ZNHjeoYlKbvSmWiwDf
 L/HeOOqSKA2h/zI0KlpoxvwBc9U6PbIF4E5hPWJkNqC/C21kAAKJxZZDgqQ61TN3sad4
 UlHfjWtd/g0Q0qJ3Yuh6sE/XmieHDYKV9Z6lFdrqji1AvmTNzazdBE4NT89p04FLp5SW
 flxNThoZspcoDTShMCMoM4W58QrG2wKbE2CGkyT5X1I3XvqgNqRi47g6BsMLscJDBrgd
 eDF5GAjKvpNj7z18ZEEV5dV3w64pljV5NTjhY3b5MOeZ78BRvu8MujnNi0ZFBCxSyDiN
 r84g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ommqHBkb
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

USB fastboot resets the device directly from its request-completion
callback, while the network transports route completed commands through
fastboot_handle_boot(). Keeping reset policy in the transport makes it
harder to support callers with a different reset interface.

Send the USB reboot completion through the common handler as
well. U-Boot proper retains the same do_reset() behavior, while
execution-phase-specific policy can be contained in the shared code.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/gadget/f_fastboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d..471c0e87042 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -422,7 +422,7 @@ static int fastboot_tx_write_str(const char *buffer)
 static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
 {
 	g_dnl_unregister();
-	do_reset(NULL, 0, 0, NULL);
+	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
 }
 
 static unsigned int rx_bytes_expected(struct usb_ep *ep)

-- 
2.55.0

