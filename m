Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06D606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L+NtJNvB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EddAZUvE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F79660DC1;
	Wed, 11 Nov 2026 20:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hp_OPW_naYUA; Wed, 11 Nov 2026 20:11:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D0BE60DE2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427885;
	b=ItyK5RV3Fk8DP1R0WFwKnpnrIGFP6cnJpOq59FTLyXzM39l6Jj5HfI+UJpceW+/49A3E
	 rWn9i2tQJLn0+vIPjnhiUsnN28xHTLr2rHh27qMRK8y9mQsFv1z6Dk7R8FZerMSjJ98yT
	 oDOYtt4Dl/kXOs19lmqwRPfuGXqjf+h0dclvbTEP0medlqDIqo+ZeX/Ly/H0qrSKWk5Ag
	 uZbXhr/8i9QPtl8YC3OkAxyMLnmkhdR1E+u0WTLmn/uj3GG91G2RdMs1cgxF71VGygtN5
	 SdpRnDW8VkmfPkrsWrujZFInNPP6LtXxo7wsMgudkF6aFv+4dtorycPC7qAHcJEeUUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7PN4XvBrqovYFAuW2gPUNYi9mrLup5EpglXrycZwlvg=;
	b=IK4QLYMdZRIUdJ6Sp6se3s6dmxnVOKt0Pvu5Yxh4HGEwOvqdA4bVS9ouD1KHpmLWv0lt
	 SoJVzX/oWcqhIAJcu0B7s7nI7KDbi37nzvD8cfkaZwWQJQNUpmGcwzSuIT8sELDewIRNk
	 ltC8Wu7d6TmUy6zFhBSQez+IowI+eIJIJuIYF3oBtxAfvOp/LTtuyfX1jqjdlH2+C23Sx
	 TYATCnLB5xFWz6VyXrEjaI4s30UBu0P6P+lls4/9LL85ynHHm7xgLIsD9MQCt+69GISTO
	 uzP3+ITormWIhLWbg+VBAIw3A3Y84Z/8m3hoElK5CAVltEPNn94ku5d+VvIhJdrfSCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427885;
	bh=7PN4XvBrqovYFAuW2gPUNYi9mrLup5EpglXrycZwlvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L+NtJNvBrfM3pD6AQLU7xfqq0TXawINRZ1QekL3hjdE0oWW4wSxddyOR1g2Tc6Srw
	 dF767Jux95SDbyxyjZY1Y8OAA03vJPI2l1uPcadHJFQN4uqifZPjFZ1AKvaq+drste
	 qgHUn10fAw91NAecRasY9cEGTxL8HkR88aDCteoAzH9iMTgowFV37VonOS3SLpkzEy
	 jk7OY24404pRJwgKPGNYwUwFrI/r4zI0VCal8k7L6jlrZWyJsSXpXlZzsjxTVKonWN
	 A4zoGkbRnU+i/HcFQPJzXYGWFpFSJvtV/zAVNSPVQsMeeWHc/t80YynBdkCAK9fMOy
	 1gdqgQvwzYLbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D0BE60DE2;
	Wed, 11 Nov 2026 20:11:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B357AEC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B07C6403BB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9PYzpyy3got for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0789640336
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EddAZUvE
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0789640336
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:20 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so2245968b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427879; x=1795032679;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7PN4XvBrqovYFAuW2gPUNYi9mrLup5EpglXrycZwlvg=;
 b=EddAZUvEo661Nln7SCDotvRqXm/7TM0IunpDubsodXuBf7Al6QZL9Ym6GozcK2UCIP
 v9kG8vui2y09/xnivobBwt9M14Cm7fmVfw2uA9P9aG/UkDaekhGQqGGQ6NxLbslKmEq8
 kKxPYK0IuRsc8bDai9J9DkgLBvCfa0b2yRBsIB4UC5R8i1JuG3tpJgkT0wJvk7Fl8h0R
 EgLjXICnEpTHwl65KR1fO0LAPlwpIehb8CChJHOXgYgVqcpBPeaD+RQBUKtHG7sKBAhZ
 b1gPNXcyDVfH0Lyot46cSsUMSky3LOc6B2aa0RJ3nA8y9NWKs6lwc5Oiy/p7lJT5wtcn
 w/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427879; x=1795032679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7PN4XvBrqovYFAuW2gPUNYi9mrLup5EpglXrycZwlvg=;
 b=AQeB2i0N2Av16EyYSGDU9xOrtDCGBS/eZIQdJhjIhj933faUKvuwlzvyyvhCb9HZ9h
 3/jkhn5JclhTjCdY8IF8uYmaOImI3D7uDuHrrd7IRdBKorZYeGErTcOOxA/YH9ll/gBQ
 39TZeWLu9QC0IAIqs1PbJnrQSj4bBeL+Tnd86tQ/RRvPxlUZ6gIAsFtefvcIsHv/p5zT
 hq6gEo4O8TCyPrp3sQKBa+wgrs8uvt4ZNFF9pfcSOugCYGCv4d1DGxaS7dsJ4uN7Z7h8
 dnis6gM2KA4Pyq0bz8P3oCLbS10N81eqbBTgHxlgXrm7KAKmwm/iGS+1sfrUM+eL+meJ
 7AwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFuj49mpmPvw+xC5ylrd8D7xOPU+ByA0QXlrVqaTWHTD0NpCJOjz9WzvTkfCd8JlPoINweDMUw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+zyPe1b9zc5uLsRVphF6WVlx8f+NlfULoPEu4/srBn2p7LjXuQ
 JEftVRNTqYRRVgGzlQTK330Yd7ahB6S9JdhkC/ZxqVIs/9SNK8Xy6sGb
X-Gm-Gg: AYBFou2rJxmnAnVx/iied1aBRFAcTwSfzZcwYBJZMejJu0knk8hd5V6u9DlG0qnPnU6
 cNq69ZXMxkTRvBMhCHZGTLTbedRRKOVQOJ7PwYvoYepGBsGX083Xbi9L9Bql5fufZj9iv/uCNZ1
 SgyJeyR7EySHKmbiE/2+hTaq2Ek5IMYyznL8lGQoEF8TgqyI8e+HWNZJT864iGGhirVK5c7uP4M
 bU7fPoNIAqmB07oGw/q8t+jvsAPO9pYPNA4fCBBDtnReFktqEYpBEG55ngNhRA6Oi7T7fRMmOuV
 8erEfFZvcwpHZqnLQY+x2adcvnLXJojkxfsuWm14RGBSrzH1GBtgs5k9Tm0e9JE2HtBpmvuQ0Li
 H71XK1q3Vz0jZZ765gKPaHv2DYZlh4M2NOAFd0LDpRA9Y8J/+pgdDqZ1soZrqMAdlvKaEd9WOo6
 6a8xge4MItOtcMxcDYAOenOfzn3P6l3dkW8LCYZbOYre1kNHKgmdYJrngmONkUzI3F2c0bcdlS1
 ZWlLBYZR9Bak1gTsC4XotQ0sLdg5Wp7Mppctzggn05aUn1s8h3+F6j0cMFN4qdTTnd8n+KQag7c
 e6eUGRCCpz4yWLjOFdJt40ECDAMT0kOb2E6fx3PubLHLgtohxagVA5fEbffLtsJ57ts2wHhKHJy
 gyLqCvtY9ywq58lBzs3MtNA2jrkV7jADEefdaOlSwkA9sNC8FVvllftZAfQDSJ56ArwnLP1yRgt
 QmRacpygtnyYmLy2LgG9N9XS3zu6RZi+6UZAnKb+4p9gKGD7WlO0U=
X-Received: by 2002:a05:6808:2203:b0:567:ba0d:a565 with SMTP id
 5614622812f47-56b98d2f795mr3422342b6e.68.1794427879226; 
 Wed, 11 Nov 2026 12:11:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:18 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:09 -0700
Subject: [PATCH 02/19] net: sandbox: bind raw packets to the selected interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-2-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SO_BINDTODEVICE does not bind an AF_PACKET socket to an interface. Use
bind() with sockaddr_ll so packets from other interfaces cannot enter
the simulated network device.

Do not overwrite the transmit destination with recvfrom() source
metadata. An incoming frame otherwise changes the interface index used
by the next sendto(), redirecting traffic to an unrelated interface.
Receive without a source address and keep the selected transmit
interface unchanged.

Store the hardware address length in its byte-sized host-order field.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/sandbox/cpu/eth-raw-os.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index 42f291a5519..52f8fb559b6 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -84,8 +84,9 @@ static int _raw_packet_start(struct eth_sandbox_raw_priv *priv,
 	device->sll_ifindex = if_nametoindex(priv->host_ifname);
 	priv->host_ifindex = device->sll_ifindex;
 	device->sll_family = AF_PACKET;
+	device->sll_protocol = htons(ETH_P_ALL);
 	memcpy(device->sll_addr, ethmac, 6);
-	device->sll_halen = htons(6);
+	device->sll_halen = 6;
 
 	/* Open socket */
 	priv->sd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
@@ -95,8 +96,7 @@ static int _raw_packet_start(struct eth_sandbox_raw_priv *priv,
 		return -errno;
 	}
 	/* Bind to the specified interface */
-	ret = setsockopt(priv->sd, SOL_SOCKET, SO_BINDTODEVICE,
-			 priv->host_ifname, strlen(priv->host_ifname) + 1);
+	ret = bind(priv->sd, (struct sockaddr *)device, sizeof(*device));
 	if (ret < 0) {
 		printf("Failed to bind to '%s': %d %s\n", priv->host_ifname,
 		       errno, strerror(errno));
@@ -285,14 +285,10 @@ int sandbox_eth_raw_os_recv(void *packet, int *length,
 			    const struct eth_sandbox_raw_priv *priv)
 {
 	int retval;
-	int saddr_size;
 
 	if (priv->sd < 0 || !priv->device)
 		return -EINVAL;
-	saddr_size = sizeof(struct sockaddr);
-	retval = recvfrom(priv->sd, packet, 1536, 0,
-			  (struct sockaddr *)priv->device,
-			  (socklen_t *)&saddr_size);
+	retval = recv(priv->sd, packet, 1536, 0);
 	*length = 0;
 	if (retval >= 0) {
 		if (priv->local && retval >= sizeof(struct iphdr)) {

-- 
2.53.0

