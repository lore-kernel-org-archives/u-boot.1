Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22BAC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90EFF80C59;
	Fri, 24 Jan 2025 16:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732386;
	bh=wZaU/zNtvtTbanGJ+UD04mAyr0999NsN8ejB/i3Rfjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L7GBuO25qxSU5CGfO0mjvO7CX06Jx7TnArke15TCFesfgYGcRxUSXPHtHrnMioVMl
	 DjCZm3Uj/8wHYTfrt756tsNi9ixYRZaONGBNL7qXrhN5fQN/+iMazCGVzpT5yH+fPJ
	 pzeGsV2CT4LCNNgOjRQIHa2S2OLHiOx0Q3vHLHijpjj2kM4ww9SdXs6GYEiOWvoYWW
	 8dTi7gGPw+vwSLc7XoNNBc/pgKT2psQOa/c5mMpjnfKpe/KNUN694kzJRdr2tHJPyK
	 6MNM72RmR3lQPUEmeKIxvIqmIkLsSd3LF14McTmg3Loo9wMvqLG9nPJ/QyMDKvRjDy
	 EapSNw/TyfaJQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545EC80C96; Fri, 24 Jan 2025 16:26:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F057C809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XuWXN9oC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C2837108873CC; Fri, 24 Jan 2025 16:26:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZaU/zNtvtTbanGJ+UD04mAyr0999NsN8ejB/i3Rfjk=;
 b=XuWXN9oCqxVUBiPGBgG/CTAnj63GJewahGTtOoMIwF14BLvmrVwXwnx/zPj28YjrpXMLvT
 LXDw9168/rf0xb5mxCZAMasSSKi7TkebiRvoVrqu/DEuChlywfyoJC4aFMFDswJMOUgqRh
 p+ygjAwQNauFkKuMylBVEYq/98OweTClR76kmpT0ysaCysf4qFYBevMH6Xb+qDqOYsAa7p
 M7bfYtxdAC2ZDxguV9SyBFiIt+aG72gIFFDj4osHahjvutmbI+IuX1uRnmrez9LiOmLAKZ
 ubl6QdQ7GR4msDaEFTnfobhe78gRGOX4Pyc4Qs3HFspaNFLm24ojVeDs1ZJCHg==
Message-ID: <05ef8aa9-fc2c-44c4-905d-13cf81b35d9b@denx.de>
Date: Fri, 24 Jan 2025 15:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-10-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-10-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/15/25 2:28 PM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> @protocols is an array of protocol identifiers that are implemented,
> excluding the Base protocol. The number of elements of @protocols is
> specified by callee-side. Currently, set it to 4 is enough for i.MX95.
Can you please try something like this instead ? That should be 
future-proof:

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index f4e3974ff5b..92d278edfaf 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -258,17 +258,16 @@ static int 
scmi_base_discover_impl_version_int(struct udevice *dev,
  static int scmi_base_discover_list_protocols_int(struct udevice *dev,
  						 u8 **protocols)
  {
-	struct scmi_base_discover_list_protocols_out out;
+	struct scmi_base_discover_list_protocols_out *out;
  	int cur;
  	struct scmi_msg msg = {
  		.protocol_id = SCMI_PROTOCOL_ID_BASE,
  		.message_id = SCMI_BASE_DISCOVER_LIST_PROTOCOLS,
  		.in_msg = (u8 *)&cur,
  		.in_msg_sz = sizeof(cur),
-		.out_msg = (u8 *)&out,
-		.out_msg_sz = sizeof(out),
  	};
  	u32 num_agents, num_protocols;
+	int size;
  	u8 *buf;
  	int i, ret;

@@ -276,29 +275,34 @@ static int 
scmi_base_discover_list_protocols_int(struct udevice *dev,
  	if (ret)
  		return ret;

-	buf = calloc(sizeof(u8), num_protocols);
-	if (!buf)
+	size = sizeof(*out) + sizeof(u8) * num_protocols;
+	out = calloc(1, size);
+	if (!out)
  		return -ENOMEM;

+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = size;
+	buf = (u8 *)out->protocols;
+
  	cur = 0;
  	do {
  		ret = devm_scmi_process_msg(dev, &msg);
  		if (ret)
  			goto err;
-		if (out.status) {
-			ret = scmi_to_linux_errno(out.status);
+		if (out->status) {
+			ret = scmi_to_linux_errno(out->status);
  			goto err;
  		}

-		for (i = 0; i < out.num_protocols; i++, cur++)
-			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
+		for (i = 0; i < out->num_protocols; i++, cur++)
+			buf[cur] = out->protocols[i / 4] >> ((i % 4) * 8);
  	} while (cur < num_protocols);

  	*protocols = buf;

  	return num_protocols;
  err:
-	free(buf);
+	free(out);

  	return ret;
  }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index a51234eda5c..29a7fd85cc0 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -148,7 +148,7 @@ struct scmi_base_discover_impl_version_out {
  struct scmi_base_discover_list_protocols_out {
  	s32 status;
  	u32 num_protocols;
-	u32 protocols[4];
+	u32 protocols[];
  };

  /**
