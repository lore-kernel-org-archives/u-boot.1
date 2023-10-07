Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E00E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320A186977;
	Sat,  7 Oct 2023 23:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XkRUVuQw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xg3on8jS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AED286D61; Sat,  7 Oct 2023 23:35:35 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E3486568
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S2z9b2wWFz9sPr;
 Sat,  7 Oct 2023 23:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7v+Qpbt98YXHl2iUgArWbHAEzOURwQxTedbxDgrVzoU=;
 b=XkRUVuQwF9x9ZQqGTa6YvwYXYDpqnuW50q6/6NW1wmBcFsAm+N1srRQX5LlgeX/i2K5tX1
 orVxImI+IUzf/08CwyrGi6sM+NVr4j5aD9PIN9GVMOI8dEMY5ZMli/DdhOEjWKbZMSMT1l
 8RJUc17x2vTR2yFwBwrXpzt9CSkVtJmUI3sbu2bC7cx5f/fr58UmQ3d09DruHbZ8acE4PW
 q5MffcjDg9CUw72I+3LERGbawUw1AXJd8HBQrbtqZbKIRdBpZandc7yXY4HyjXfbohC5ol
 9496YjodHoOFFzvowxry7tdgRHy7IvdmEMZIvT3FGrXQNvnsXmL6rlD+3H5/vQ==
Message-ID: <affa00c1-b6ae-4ef0-9f5f-8a6d6d74d0d8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7v+Qpbt98YXHl2iUgArWbHAEzOURwQxTedbxDgrVzoU=;
 b=Xg3on8jS+U3lJEq0h7dcnIY9Mgbg0XcqEpKQkisOVBqhV6gLac7vvcpGazOf2sfCTQjEVU
 vSAb1Gmq64+h4XCAx0JDtZaJFnNYZAR9WclpPCiqql6vsIOmYiLoszCFEUw+pT4qMx0ACS
 XMtpTbovtBHDFGGKp+siOA00TOvCojOoAXxosUD6SDW1Er/omsDAKsTLN3vQtqXHtI6zj5
 oOcVeuBq1bh3UExAxrzjvGKF13bW4v6cywDv45zmKtLR9z4Rd8ow7Uu/BQOR6KP9Vr1pMr
 KzncVbIeZEnj5AmzohiiXQv3e77HnuOvtNAmNunYEDpMhhr5/mOyqwK6dP/tjQ==
Date: Sat, 7 Oct 2023 23:35:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 6/6] sysinfo: rcar3: Implement BOARD_ID and BOARD_REV_*
Content-Language: en-US
To: Detlev Casanova <detlev.casanova@collabora.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-7-detlev.casanova@collabora.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231002152142.76516-7-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gewcw5ph7e3nputo5g3hqd5cb8z5xin4
X-MBO-RS-ID: cc165cd53df24a48326
X-Rspamd-Queue-Id: 4S2z9b2wWFz9sPr
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

On 10/2/23 17:20, Detlev Casanova wrote:
> Expose that information to the sysinfo command to let scripts make
> decisions based on the board id and revision.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   drivers/sysinfo/rcar3.c | 89 +++++++++++++++++++++++++++++------------
>   1 file changed, 63 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
> index 633e80bc19b..a554323506a 100644
> --- a/drivers/sysinfo/rcar3.c
> +++ b/drivers/sysinfo/rcar3.c
> @@ -32,6 +32,10 @@
>    */
>   struct sysinfo_rcar_priv {
>   	char	boardmodel[64];
> +	u8	id;
> +	u8	rev_major;
> +	u8	rev_minor;
> +	bool	has_rev;
>   	u8	val;
>   };
>   
> @@ -56,9 +60,33 @@ static int sysinfo_rcar_get_str(struct udevice *dev, int id, size_t size, char *
>   	};
>   }
>   
> +static int sysinfo_rcar_get_int(struct udevice *dev, int id, int *val)
> +{
> +	struct sysinfo_rcar_priv *priv = dev_get_priv(dev);
> +
> +	switch (id) {
> +	case SYSINFO_ID_BOARD_ID:
> +		*val = priv->id;
> +		return 0;
> +	case SYSINFO_ID_BOARD_REV_MAJOR:
> +		if (!priv->has_rev)
> +			return -EINVAL;
> +		*val = priv->rev_major;
> +		return 0;
> +	case SYSINFO_ID_BOARD_REV_MINOR:
> +		if (!priv->has_rev)
> +			return -EINVAL;
> +		*val = priv->rev_minor;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	};
> +}
> +
>   static const struct sysinfo_ops sysinfo_rcar_ops = {
>   	.detect = sysinfo_rcar_detect,
>   	.get_str = sysinfo_rcar_get_str,
> +	.get_int = sysinfo_rcar_get_int,
>   };
>   
>   static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
> @@ -69,8 +97,9 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
>   	bool ebisu_4d = false;
>   	bool condor_i = false;
>   	char rev[4] = "?.?";
> -	u8 rev_major = 0;
> -	u8 rev_minor = 0;
> +
> +	priv->id = board_id;
> +	priv->has_rev = false;

Would it make more sense to assign

priv->rev_major = 1;
priv->rev_minor = 0;

And get rid of priv->has_rev entirely ?

Basically say that the default case is rev. 1.0 board.

[...]
