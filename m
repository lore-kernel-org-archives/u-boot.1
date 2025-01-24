Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F139C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D450780C7E;
	Fri, 24 Jan 2025 16:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732381;
	bh=iEvlSOWwl2EZzzvg5EigJMuDg8lOlti4LwsFmJbGeqs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rQqS0NxWlrmxn1RpD6v/CbY3q1BeJhBW5kwgPN9p9gC3y92kY1NB+rMlSOFI/Vfvf
	 dBbsWAWFYOUOh8xl93H4acVyC0hw04Lr6qgMz0tI4D/fWjI7BGLskf1WQc+Lb8qnSr
	 /aa3U1GrZS1TcjE2B1KdeHAz7ghLvzQzwPFrn0QiD2NNXUsbUI154MpANmBuNPmlpo
	 LdPhXdxawwt7K+I/2PhAac4Ah8ac+9hmdYTrTqQPbb1PFpSqobv+76wMqSZL+rJvAu
	 oPEd83ropZLJgqunpuu3pcEfIW2SIg52w0wib5hBOwld4oQVqXxSllGA1Az4M7YbMR
	 8KsVDlNlmAXLg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163B780B9B; Fri, 24 Jan 2025 16:26:19 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2722180B9B
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="blBOg3mH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 12998101D2386; Fri, 24 Jan 2025 16:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEvlSOWwl2EZzzvg5EigJMuDg8lOlti4LwsFmJbGeqs=;
 b=blBOg3mHAuK6oc7RQRjvEhOXaU0u/+oq5pHJ1FoCqKcIdFqx7Lg1xTc4/ayomqXusZpzpk
 7WydDeYWDVfkfMRU0EMpkt7phLphbjlTYuS3f1ruTME3/pZpna0T5Kzj20jOpIO9qyolO/
 qSt3Ln8NtEleP+NnSlEmXZdUSsIPwdxayu3x5klPKEZDbxT9EUAASdyY2Lw8P5/0OklCOw
 afxjonIMBcQMBLtILlbGxGzjjidEpciGnvFmuzPDz9F16TB72GTdgmaREyNtvoDpyWBAXz
 svtbEBLr1LcFByxTlnadpm8NmnJmQM/41Ascx9RHMpH8UT6hz/BZjb5L2YorOQ==
Message-ID: <24cdad35-a255-4941-b6ed-0e7240857fec@denx.de>
Date: Fri, 24 Jan 2025 14:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/20] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-5-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-5-93b28a514dea@oss.nxp.com>
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
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI misc protocol is intended for miscellaneous functions which are
> device specific and are usually defined to access bit fields. This patch
> adds SCMI misc protocol protocol_id and message_id for getting the ROM
> passover data.
Is this iMX specific or is this generic protocol ?

If generic , then the symbol SCMI_PROTOCOL_ID_IMX_MISC should not 
contain _IMX substring .
