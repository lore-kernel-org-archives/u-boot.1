Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEA7CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B86B88132;
	Thu, 28 Mar 2024 11:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711621336;
	bh=dmL9+claA7D3D8UsaEz+XNiO6iUq1GNU47dd5/LUzk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZ9McJP4mvCS7qegLTh80377wKB1LdGy/ZvxjAagxA5Qc2EEUiN9IZWNNOfSDwgZX
	 gPoIPBNpxUy2ecbOkMmAjRNrq+xTGCHzigchCxpwJ3bu9OpqFkgATLTu6G9w9zgiBe
	 rPdJyGFzlxHSRzLKOADFcLKLB7Zk2V1px9lrx9UHpqozOMl4NvQ3qgqwTdrPgu7jY4
	 tApZ4fEEIfvAoff013TecmZY5gT8S1/G+MUQWcmwyJQd8MA17TVCRp3rvxO7DYx06d
	 DMxA1N7wGa6kTeSgnK0H6twf5XMLqXNAvZQwFJs+dOn9zDzkH2QK2N2P90ZktMnB5M
	 I9UdoLZPK9Qog==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 796F38813C; Thu, 28 Mar 2024 11:22:15 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E9D8812B
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4V502q4vmHz9srn;
 Thu, 28 Mar 2024 11:22:11 +0100 (CET)
Message-ID: <6c352943-77f0-426b-909e-fa1263085ea8@denx.de>
Date: Thu, 28 Mar 2024 11:22:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 16/18] cmd: rng: Print "Abort" on -EINTR
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-17-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-17-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/27/24 17:23, Marek Behún wrote:
> In the rng command, print
>    Abort
> instead of
>    Reading RNG failed
> if the error number is -EINTR, which can happen if the user pressed
> CTRL-C.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   cmd/rng.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/rng.c b/cmd/rng.c
> index 52f722c7af..48ba67061b 100644
> --- a/cmd/rng.c
> +++ b/cmd/rng.c
> @@ -17,7 +17,7 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	u8 buf[64];
>   	int devnum;
>   	struct udevice *dev;
> -	int ret = CMD_RET_SUCCESS;
> +	int ret = CMD_RET_SUCCESS, err;
>   
>   	switch (argc) {
>   	case 1:
> @@ -46,8 +46,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   
>   	n = min(n, sizeof(buf));
>   
> -	if (dm_rng_read(dev, buf, n)) {
> -		printf("Reading RNG failed\n");
> +	err = dm_rng_read(dev, buf, n);
> +	if (err) {
> +		puts(err == -EINTR ? "Abort\n" : "Reading RNG failed\n");
>   		ret = CMD_RET_FAILURE;
>   	} else {
>   		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, n);

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
