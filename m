Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55D8F557E4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11103842D7;
	Mon, 20 Apr 2026 10:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LFdLAwbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F61A839D5; Mon, 20 Apr 2026 10:36:12 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F6484258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=x21OUbKaoUbukD+4GY/o7AwURwsooTqmgm3Vmb0WoUg=; b=LFdLAwbu0aqb8JgzJrHPDSYtVb
 6EJILXMZNanbSA7um4TWxoDFiuZkZS0+afXfmzhbs0AVYniDg3x/GOaA7HspuNiqgvMAHXLMlFqQP
 nwrZNSufsfeuYypKWby8CkolIEQ7DhvTDMovweP5u3NaV+w2s5+HSkZ2pDLkPCjfAXElTdjorR+ap
 /LfEpf6iDxVUkracRzfQPiqAydxbymm6tE0bSnj+MkFvFKVn2gIVXvjNQJT8RIKkqwwPzjD9bUcjD
 gg50jWqtAECcsumuAp4onYuvYeiDMML5NxHx8kOS7+pJcKaL1FyXdUgUasbF5Vjif1/h8IfonlpDU
 zpNxx6JA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wEk6v-000PJS-0F; Mon, 20 Apr 2026 10:36:05 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wEk6N-000Ovu-1c; Mon, 20 Apr 2026 10:36:04 +0200
Message-ID: <b0bb28fb-9e83-462b-b228-d9e3771290d3@ew.tq-group.com>
Date: Mon, 20 Apr 2026 10:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: Re: [PATCH v4 5/8] arch: arm: dts: tqma7x: add boot phase properties
To: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
 <20260407130654.778838-6-Alexander.Feilke@ew.tq-group.com>
 <CAOMZO5AEzBptEzN_mvS+CDhEe7051ZuPLK9kQN5Ty8nuibNL-g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5AEzBptEzN_mvS+CDhEe7051ZuPLK9kQN5Ty8nuibNL-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 19/04/2026 21:56, Fabio Estevam wrote:
> Can you add the link to the upstream submission?

Here is the link on lkml: https://lkml.org/lkml/2026/3/6/1623

Best regards,
Alexander

