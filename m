Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AF7C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 21:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCE582836;
	Mon, 14 Apr 2025 23:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OS5f7KtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6088D820F8; Mon, 14 Apr 2025 15:35:34 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D856381F30
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E06D1FCF1;
 Mon, 14 Apr 2025 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744637731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xO6JUZG5QhSPZtBmBk+kWnYbdmvqMtCiYGwfWL8BGCw=;
 b=OS5f7KtSmxT45KKJ5ZkXsX5fG91g69nbcXkaUr3+aCRYFWH1AJV7Zr0Msjg6OMzignVzUg
 XuIRJosorpqpuZjIMNj/XUdlZpwaqq3/QyDPy8CCxbplHa+v78OrA2TkGQAocCbgxhioTt
 e2zmHtn6DwZ7RD9EPtEVK+JHr+bzQgMqZEFV1SzcN/o4GVL0bkCNV02QMi+6Tttr8YGLNI
 e+G7QA4D+XuvSBjOIrNXscFZiqL/u+dxx7H0GsNeDHGCtdcNnjg8XvoEBWYEFft1rJrdsj
 4JUHFMOHXkXeDJ8qELjj9ZakNZGZXwaz/ZNbYfH919EGPYgcqogyoC09/XwGtQ==
Message-ID: <e86091c7-3dd2-4cf8-af97-673609dbc79a@bootlin.com>
Date: Mon, 14 Apr 2025 15:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] fs/squashfs: avoid illegal free() in sqfs_opendir()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 Andrea della Porta <andrea.porta@suse.com>, u-boot@lists.denx.de
References: <20250414131924.86672-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20250414131924.86672-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhohgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohgrohcuofgrrhgtohhsucevohhsthgruceojhhorghomhgrrhgtohhsrdgtohhsthgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfehfeeujeeifeektdfhudelgfdvlefhgeduuedvleejjeefveffvdeuveelteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmegusgefsgemugduvdgumeduugeljeemtgdvfhehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmegusgefsgemugduvdgumeduugeljeemtgdvfhehpdhhvghloheplgfkrfggieemvdgrtddumegtsgdugeemheehieemjegrtddtmegusgefsgemugduvdgumeduugeljeemtgdvfhehngdpmhgrihhlfhhrohhmpehjohgrohhmrghrtghoshdrtghoshhtrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehhvghinhhrihgthhdrshgthhhutghhrghrughtsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohepjhhmtghos
 hhtrgelgeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopegrnhgurhgvrgdrphhorhhtrgesshhushgvrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-GND-Sasl: joaomarcos.costa@bootlin.com
X-Mailman-Approved-At: Mon, 14 Apr 2025 23:16:34 +0200
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

Hello,

On 4/14/25 15:19, Heinrich Schuchardt wrote:
> * Use calloc() to allocate token_list. This avoids an illegal free if
>    sqfs_tokenize() fails.
> * Do not iterate over token_list if it has not been allocated.
> 
> Addresses-Coverity-ID: 510453:  Null pointer dereferences  (FORWARD_NULL)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Fix typo in subject line
> ---
>   fs/squashfs/sqfs.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 7c364686f14..2dcdd60f683 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -949,7 +949,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
>   		goto out;
>   	}
>   
> -	token_list = malloc(token_count * sizeof(char *));
> +	token_list = calloc(token_count, sizeof(char *));
>   	if (!token_list) {
>   		ret = -EINVAL;
>   		goto out;
> @@ -987,9 +987,11 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
>   	*dirsp = (struct fs_dir_stream *)dirs;
>   
>   out:
> -	for (j = 0; j < token_count; j++)
> -		free(token_list[j]);
> -	free(token_list);
> +	if (token_list) {
> +		for (j = 0; j < token_count; j++)
> +			free(token_list[j]);
> +		free(token_list);
> +	}
>   	free(pos_list);
>   	free(path);
>   	if (ret) {

Reviewed-by: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
-- 
Best regards,
João Marcos Costa
