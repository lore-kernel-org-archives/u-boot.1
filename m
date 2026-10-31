Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Vqa77lYJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ug5kOEFr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C1B060ABF;
	Sat, 31 Oct 2026 06:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rSPMKm_ICNzO; Sat, 31 Oct 2026 06:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05AA260A88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793427426;
	b=SNyGRWT1FkZMxKpZPxut5iVlIQd6bTVyD06Vbh1hihnsuztaa4uluW/I6dLA6DP6e7Q+
	 lHCR2vL807jFmV4g16OIiDW2Fash0UnAj3Jwu1JXUrT/SIHTbIdeVfbfDi1eE74rBW0e8
	 UjLPFgTpTJQamvOkYgfeCF33I6akbKOaQu1awOi/hzORo6bvsb28Ee/uQG4Nf+MdXymUc
	 IZmG2f43FVdUjv7MJzi9Q5aPsDUZQLHtScNJfZ1owY9KtVUxavFlhHnNJmSpmp0SVIYjj
	 vUS91QAayGwlvU5p7QkXvPk+hUu4XqSNyzt5cX5uI69wA7HOiCEXPZh0+ieI968TxEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793427426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TpTINUNJ/1MniOZjEy8gAi2OnKbYUjWuU1R6NdZlpHw=;
	b=nLE+WMw016L0U1/sO+uT1D2M4hwGP51GnlUN8SXrmtS/rGMXvIY4ObGaC1NZQRVPhnxn
	 JNvSWrNuQEGuLh7SmkqjMT4J0E9tQAYWXg+3Fn8OpUDcNHlkafjP+d8wFPiU34pXcXXzj
	 aRevICFChLMiGDA2bQG4k/7OQ30obkPq+Wsz56ZUKp5E9LApM5OqnaymPkak0fkOJ5/vI
	 x+Qf1ILpLrwZCzMK4oM3ad1y7z6dfh3PrATrDuVZzmGYRPmeJyEMXMqV1poeAUPJjSkzt
	 OTVc156HIY8Mbyqx3Fkc9LhhhZBRuSC7+8dc0GmJ2ndyR3WRpXTgVa12Ey8hcnJsC2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793427426;
	bh=TpTINUNJ/1MniOZjEy8gAi2OnKbYUjWuU1R6NdZlpHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vqa77lYJyiEbCZuZu69o1wzy6L6v1z80QnH1iEoITpipQkCktxc3Xg2kuL+R5YCil
	 W2gdG/Z13YsYSfOn9wk0lEo0xM/j4QB3AR955VcUzjuOaKv5c6b32NqWU8JWxh4ptu
	 rsse52B8od0MxjlvH1jN2ZWEskUXkrL5raXv51kSf2nDSgxlaCrO1X4yH/9NSVP0hq
	 xXPFqb85qPvRX+MiNjq/fWzEC4bNlGJqmiCvQ4HjkUXulqPSv5ZcUDP7y3lfAB4mp5
	 pAogYBK1AsAuxIgpcyweScXZ9OHi8ZsoGjQ/+H2DgPOAvXhhZhMbp6K4fJiVS2RKcq
	 PvXwrzE3MhTzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05AA260A88;
	Sat, 31 Oct 2026 06:17:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DD1B235
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B64E8112F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8I6vqaWUphVf for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D32B81150
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793427424;
 b=Ws1i2pd5RucKTkjcXitUqTHDhh/vQY7k26aOd1/G+Nzd76wIRPUg8E8jTVHGtMPqGttr
 xXrPSQrwFMOrnAsTsoP4ZEbkoYIjmG/lQPUruBTVdg35yOjmiGx8ZcMLgpaLmw0omNUCg
 6DSe/xCvVKcG98j41zc2Wh/sFvIHFsZ4jB0VjiBCEoV1jhhWJ2FNQPNs81D/E6bUZnCjr
 zFgJoiQkNQS6OYGupeIpAOL7c5E9sIL6xpwEY7NqDcKbrck9H9+3J5JJk0jeNb7nRHfxa
 UvBYefVjbQ0qgnBRXayHoLPjhx/Dyj/lOJap2ZeQRmuxv3h8BYST7+ljYKhWVqzpGeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793427424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=TpTINUNJ/1MniOZjEy8gAi2OnKbYUjWuU1R6NdZlpHw=;
 b=oXPCi1/GAFnWAaF4s5T4+y8esoz+38qVAxUI7autxeeDdpbfblydi9iBxszS2YECAjB3
 wd0gJwTodC/g3C9sSNmA3z9fRbyq+ct3dyeJVrzi6lLF6Pe1Ps9EOzdF6vKiai0QnMued
 M/e+8/zT8t3ubatylld5hmWbjXiPvxuKzDJV+KzaZMr4rhk9001Fgpx3c6xe+28JsQVPn
 3kf7rl3UmPTzVmt+JJGqLWgqO2f9RmEr+V9lkWtovFZC5x8bqVYo8a5PmdVmFXvt3MJMb
 YWHZSjZ/KK/15/hJdfQKjt2gIZbcxIKPMiJc725LbdhcbnnWqZGj6EGbe57ty2jmXhw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Ug5kOEFr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Ug5kOEFr
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D32B81150
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:17:03 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so10949175e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793427422; x=1794032222;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TpTINUNJ/1MniOZjEy8gAi2OnKbYUjWuU1R6NdZlpHw=;
 b=Ug5kOEFriMEmafilj9VSQUj6vSoAU5InRVpvBCCJjeXhLC54eMasuniKi7EnO/JMfV
 ZAw3vZzmQjjnXN/NPK7qKEiM51/OBQBpKGmfwDZdGTHGkshlhw93tweXyEWN9ai9iEq1
 N5uQQGnxmDRaee6jclgDX7VNZKEdG4k1HxJYn/zETI3lsKht3Z97lXaPQ9aITZo+y+es
 CRKU9TVZRfju+OJOzcQY7381mHtGFyFEjXFwYNxpFnvcwsERC/RgimsGCYHjs8OaUN8p
 EPIEhwxs6Je8nmo3RKL9yCOLYC9yn4dRRBqtzsG/B9fJb6P0W/1Z72gZO+heF4ybCirn
 Ydgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427422; x=1794032222;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TpTINUNJ/1MniOZjEy8gAi2OnKbYUjWuU1R6NdZlpHw=;
 b=0BbCHKryE3iBCUY4nAN/ZSXjrhQ01cRSBeb2lxu25TpTAxTql141K7gobLzWvHQeRj
 lxpYbrFRhbbjhCDPzfrW+V9gsBgUVmNoCab0yR6MGncucd66Rws8aS9xE2FoCrLsG39w
 3xV7cAZxBSkdp9RiXjqmDpKTVMzSjuXLlhOkfRT7kBVQ8H2RQ1j1vOjLFPUAWNhMVJkt
 yGJczOE98/G1M7C9aC3bbqcQ2AaZobLA+FjOjkt+Nf+dqTdpOugpRozwpZ/DGDjoL86C
 DgAgJDFd4DRJQD/QV2JaVhb79au3qmnz5BPp/7jbYQBzdjNVGBMNO1F5+LCG8psSwT0p
 OS0A==
X-Gm-Message-State: AFq9FYLfq6fIy+PUSSuktZuKRMYmTcWlaZt6b6fdVAz5xFr/ctBs3SaT
 gUGBYwvF8sb26b03/McArc5CVOMgfdXxoVxXyOjEcU2Gw8mTPLIUzwKGFtnSz2cC
X-Gm-Gg: AYBFou3mkkib9HEntpyZ6rp8Z3USHN8+48J1qwjo7WbAKivYHv7cbuPu1n35djgS06X
 cTcuSj4UFD7mR3iZF256a4r47panIhMWr7boFoAybl/NCiwE0+DpSYJQu6FxkzK2ad/jKZtHtXn
 3p5Q+VR4bG8fJTyYdSRxRL8mOgV0nxEzQP7j5IWaTKdJRJDXPK5ds0j0TtXB3lCJ0XUo0aEay9f
 JWBTs7OFqbqofRjM5JmZATw3eK0V6/KYw+ufJ002LD4/WxhEnZKde5PiQ6PbBfhjUsXeAoukChr
 IE8L6n61roFDft0Q+CAUG5P5agPKJooYoRNoC69+oeYbV3NV8vnM/MwEZMBMfTxBH4kpoH97KMN
 ZquuSLfXMGgqewo7vHiBDN8ZkKYAOLDyVBG/xqLhD78fl571U0y6m9CkUUUEL0wCw+LI3Mm3N0Q
 8q5Tdg+IHUR7zeNVpVcBd+MgFkeC/pnKA53mmo0cbdZdu0hz+mzh9lgPPAJq5RDlFpLThQ4JZgl
 pOSaBCal5JtzbTVmKaZjfFdC1BbvwHRN2yVCgcPah+cFUQCbzEoNjQz4DgBuauC6PN0/yU3YRFi
 rOkl3qcaiUb7PMkhHpqsRc7YfnvX2GftxoY8GxS4wLHsE3Yr8Z4e
X-Received: by 2002:a05:600c:4454:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ac1794032cmr98743295e9.16.1793427421871; 
 Fri, 30 Oct 2026 23:17:01 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm7379678f8f.30.2026.10.30.23.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 23:17:00 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/6] usb: hub: don't use more ports than USB_MAXCHILDREN
Date: Sat, 31 Oct 2026 06:16:59 +0000
Message-ID: <ab3eb3aa-6f0f-4540-884c-30906d0676b5@gmail.com>
In-Reply-To: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
References: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

usb_hub_configure() takes the port count from the hub descriptor's
bNbrPorts, which a hub may set to anything up to 255. The port bitmaps
it then copies (DeviceRemovable, PortPowerCtrlMask), overcurrent_count[]
and, without driver model, children[] only have room for USB_MAXCHILDREN
ports. On a hub that claims more, the bitmap copies run past their
arrays and the port scan indexes past the other two.

Only use the first USB_MAXCHILDREN ports of such a hub. Linux refuses
the hub instead, but its xHCI driver first limits the root hub to the
ports the hub code supports, while ours passes the controller's port
count through. Limiting the ports keeps such a root hub working.

Make the sandbox hub emulator refuse requests for ports it doesn't have,
rather than index past its port state, and add a test with a hub that
reports one port more than USB_MAXCHILDREN.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 common/usb_hub.c               | 21 ++++++++++++----
 drivers/usb/emul/sandbox_hub.c | 29 +++++++++++++++++++---
 test/dm/usb.c                  | 44 ++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/common/usb_hub.c b/common/usb_hub.c
index 6a4bcec00bc..6bfe3784a97 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -658,6 +658,20 @@ static int usb_hub_configure(struct usb_device *dev)
 	put_unaligned(le16_to_cpu(get_unaligned(
 			&descriptor->wHubCharacteristics)),
 			&hub->desc.wHubCharacteristics);
+
+	/*
+	 * The port bitmaps below and overcurrent_count[] (and children[]
+	 * without driver model) hold USB_MAXCHILDREN ports, so don't use
+	 * more than that.
+	 */
+	dev->maxchild = descriptor->bNbrPorts;
+	if (dev->maxchild > USB_MAXCHILDREN) {
+		printf("Hub has %d ports, only using %d\n", dev->maxchild,
+		       USB_MAXCHILDREN);
+		dev->maxchild = USB_MAXCHILDREN;
+	}
+	debug("%d ports detected\n", dev->maxchild);
+
 	/* set the bitmap */
 	bitmap = (unsigned char *)&hub->desc.u.hs.DeviceRemovable[0];
 	/* devices not removable by default */
@@ -665,17 +679,14 @@ static int usb_hub_configure(struct usb_device *dev)
 	bitmap = (unsigned char *)&hub->desc.u.hs.PortPowerCtrlMask[0];
 	memset(bitmap, 0xff, (USB_MAXCHILDREN+1+7)/8); /* PowerMask = 1B */
 
-	for (i = 0; i < ((hub->desc.bNbrPorts + 1 + 7)/8); i++)
+	for (i = 0; i < ((dev->maxchild + 1 + 7) / 8); i++)
 		hub->desc.u.hs.DeviceRemovable[i] =
 			descriptor->u.hs.DeviceRemovable[i];
 
-	for (i = 0; i < ((hub->desc.bNbrPorts + 1 + 7)/8); i++)
+	for (i = 0; i < ((dev->maxchild + 1 + 7) / 8); i++)
 		hub->desc.u.hs.PortPowerCtrlMask[i] =
 			descriptor->u.hs.PortPowerCtrlMask[i];
 
-	dev->maxchild = descriptor->bNbrPorts;
-	debug("%d ports detected\n", dev->maxchild);
-
 	hubCharacteristics = get_unaligned(&hub->desc.wHubCharacteristics);
 	switch (hubCharacteristics & HUB_CHAR_LPSM) {
 	case 0x00:
diff --git a/drivers/usb/emul/sandbox_hub.c b/drivers/usb/emul/sandbox_hub.c
index 3b3e59f978f..066898f005e 100644
--- a/drivers/usb/emul/sandbox_hub.c
+++ b/drivers/usb/emul/sandbox_hub.c
@@ -198,6 +198,23 @@ static int clrset_post_state(struct udevice *hub, int port, int clear, int set)
 	return ret;
 }
 
+/**
+ * hub_port() - Get the port that a port request is for
+ *
+ * @setup:	Request
+ * Return: port number (numbered from 0), or -EINVAL if the hub doesn't have
+ * the port
+ */
+static int hub_port(struct devrequest *setup)
+{
+	int port = (setup->index & 0xff) - 1;
+
+	if (port < 0 || port >= SANDBOX_NUM_PORTS)
+		return -EINVAL;
+
+	return port;
+}
+
 static int sandbox_hub_submit_control_msg(struct udevice *bus,
 					  struct usb_device *udev,
 					  unsigned long pipe,
@@ -228,7 +245,9 @@ static int sandbox_hub_submit_control_msg(struct udevice *bus,
 				struct usb_port_status *portsts = buffer;
 				int port;
 
-				port = (setup->index & USB_HUB_PORT_MASK) - 1;
+				port = hub_port(setup);
+				if (port < 0)
+					return port;
 				portsts->wPortStatus = priv->status[port];
 				portsts->wPortChange = priv->change[port];
 				udev->status = 0;
@@ -247,7 +266,9 @@ static int sandbox_hub_submit_control_msg(struct udevice *bus,
 			case USB_REQ_SET_FEATURE: {
 				int port;
 
-				port = (setup->index & USB_HUB_PORT_MASK) - 1;
+				port = hub_port(setup);
+				if (port < 0)
+					return port;
 				debug("set feature port=%x, feature=%x\n",
 				      port, setup->value);
 				if (setup->value < USB_PORT_FEAT_C_CONNECTION) {
@@ -261,7 +282,9 @@ static int sandbox_hub_submit_control_msg(struct udevice *bus,
 			case USB_REQ_CLEAR_FEATURE: {
 				int port;
 
-				port = (setup->index & USB_HUB_PORT_MASK) - 1;
+				port = hub_port(setup);
+				if (port < 0)
+					return port;
 				debug("clear feature port=%x, feature=%x\n",
 				      port, setup->value);
 				if (setup->value < USB_PORT_FEAT_C_CONNECTION) {
diff --git a/test/dm/usb.c b/test/dm/usb.c
index fa894c1096e..7f803f9fe01 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -456,3 +456,47 @@ static int dm_test_usb_keyb(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_usb_keyb, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* test that a hub reporting more ports than we can track is limited */
+static int dm_test_usb_hub_ports(struct unit_test_state *uts)
+{
+	static struct usb_hub_descriptor hub_desc;
+	static void *desc_list[8];
+	struct usb_generic_descriptor **ptr;
+	struct usb_dev_plat *plat;
+	struct udevice *emul, *hub, *dev;
+	struct usb_device *udev;
+	int i;
+
+	/* Have the hub emulator report more ports than USB_MAXCHILDREN */
+	ut_assertok(uclass_find_device_by_name(UCLASS_USB_EMUL, "hub-emul",
+					       &emul));
+	plat = dev_get_parent_plat(emul);
+	for (i = 0, ptr = plat->desc_list; *ptr; i++, ptr++) {
+		ut_assert(i < ARRAY_SIZE(desc_list) - 1);
+		desc_list[i] = *ptr;
+		if ((*ptr)->bDescriptorType == USB_DT_HUB) {
+			memcpy(&hub_desc, *ptr, sizeof(hub_desc));
+			hub_desc.bNbrPorts = USB_MAXCHILDREN + 1;
+			desc_list[i] = &hub_desc;
+		}
+	}
+	desc_list[i] = NULL;
+	plat->desc_list = (struct usb_generic_descriptor **)desc_list;
+
+	state_set_skip_delays(true);
+	ut_assertok(usb_init());
+	ut_assertok(uclass_find_device_by_name(UCLASS_USB_HUB, "hub", &hub));
+	udev = dev_get_parent_priv(hub);
+	ut_assertnonnull(udev);
+	ut_asserteq(USB_MAXCHILDREN, udev->maxchild);
+
+	/* The devices on its first ports are still there */
+	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 0, &dev));
+	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 1, &dev));
+	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 2, &dev));
+	ut_assertok(usb_stop());
+
+	return 0;
+}
+DM_TEST(dm_test_usb_hub_ports, UTF_SCAN_PDATA | UTF_SCAN_FDT);
