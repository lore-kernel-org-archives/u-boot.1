Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA8606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BuDjuWWI;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=MH60KL57
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB32A40501;
	Mon, 26 Oct 2026 22:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LEi99vQ7muwf; Mon, 26 Oct 2026 22:49:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F611404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793054974;
	b=gELXnWrFv818AMlSL0BsLfdXwPlAscoN4YEz02AkA/74DF+Sr1EBHz2eBhcr3+XBSGSE
	 szq6H4F7j9rINx2RoHwF/Ly82svW7lAmVkDXKUL12VZJWTSn4riVWZ32DhmXW7Z7ORZA/
	 ZWZDfxklzGLvwotnTESKhl22mPsiESMmAUuF6epxR5AJ6q7WjzhFu7THqPfQF0BXFLYT0
	 rD8mhnnkzMMugBK6zzXVUeSOyXLejaDRA2Jk4mpPmi6ZZcOVozN80KrDdE0yHutwOPGdp
	 YQTsuYcdEmkJSFxgWwU8bfyRrLyitOrE2Trk+8UEe/B+wVf87DDseWq67n/d3rSVzog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793054974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F452p21Zvvk/D4SziICEZXHyMEwGXLwLUCBlSAmRkx8=;
	b=kEwTIb+xukMlVd68mGqkkdWY2ImpiIoafCQzQ6Vb2KBb7d1W3HfeXTDkca4D8BEPoK8r
	 h6+lLDsCxtYGv7sNzVL+MM5ZJKUoQ5GNtUdAeisdhX1q6m7BycHTz1Nk1qjvfYn6Yd7AK
	 rMTs8atF91drWTvjeJ2C3zKwxpQuVVftP7OZm0GtoNGuX0my7lryCpmAGmmKw65O5pRcT
	 8YXoi9bkkbw0HcSm9bQcB3VYt0zGHpktUAN63kabfZQ4w5J5fvVudRtSFQPUK6++LJWEH
	 RxPS4AYipT47zOeQADmH8ugtd+r1GlPbLqnA3G2RKkTmvv3r+tMgpfHPVjEk44Hm32Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793054974;
	bh=F452p21Zvvk/D4SziICEZXHyMEwGXLwLUCBlSAmRkx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BuDjuWWIbkxVCKCKZGX+Wp1TpYhb5iECGz2CtJMyQjgdVMHTWwNirFKzHIO/eAi1R
	 /QB1qQZXJjsONqgkbfdDmDqhWZwJrFtguQOnfk9dLefI/dVpfHm1jKqngQJ3l2ILBe
	 yBn9Z45Np0M63YE/d4gzWWFWZeUSSvTiU4Wfj7qhWXYT/Ee469cV6w1t3Jw0wGEYQI
	 P7z2oGgrXF7OSItGOIITaUKqAbsOe6NEe2GkBif/9qrhTNk6ZArq5/6JUer6Hk2vTM
	 hSc5PCWggkEsv6ste/N5deln8Ol5C0JFM+YNRYfl6IsNbLAq0dzqj6loc7EcO0pweD
	 uoUBoekvoj+BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F611404F8;
	Mon, 26 Oct 2026 22:49:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D825120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F2E340205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Skh39DwPEkLr for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:49:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4BD7D40062
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793054971;
 b=YTGAWG+NtMr3QgxqSf3+DjEiMwdjjjhtYRNuqBsELpbpzTnOebc8c8l09pXEWADtLmMz
 fzricVdV+Oo36Az3SazIcuG2W/mmtkQhML98LLOJHqr2woC5Wmnxgn9ASNNfJ2XhTDVdX
 i0Zmta0tk2IooKFrrhMPhFTIg6WTpuEe3y1150yCzSNV9slD0DSoeLMnmjt0QeAUNIQ8+
 pe4BVLQf09cRKO0aFs0ln5zUAWeU62yB8dSgVXXedmWW7fHsEmw7kPRtyVSdTtrQ5yJRD
 XmBVDfrlALHizamCNqhpGGiTOth/CLcgSH7CYShOhXRYka3IEGdPwQkuTSuZuYjHzZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793054971;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=F452p21Zvvk/D4SziICEZXHyMEwGXLwLUCBlSAmRkx8=;
 b=FB7p1zheOiFPFHlMDAiCUgk7Klc1hyCl+tC+ItS7ka4pjZAlQ/wNClQE9wN+AjcMs2C8
 3JnnTpG9vWYHGEAlFR9XDDVqinxKHksq8Qsa4l7ga7Qg8fdu87k+4/lfYm9ktUVEiY/7X
 KTdNaRjJYOWzrNCqvIbBWD0Ck0a7n8Ll0/b7crj0id+LL7TfMCKVo50/WzNpznfMM8NG9
 B6RbqJ2ZnYblvu7qW73masROxc8gkF/Z4rhWL+BpuHU+mZVfGFeA2a731ySehpOBKJLHc
 fGUyOjkSbvQvSgcZuUE90Ab9FgBnQaP6Rx0lhuRqZQ/lcNeser+zHdzKYcmTyHHjcRw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=MH60KL57; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=MH60KL57
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BD7D40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:49:30 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jD82G3vrkzMlM0;
 Mon, 26 Oct 2026 23:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793054966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F452p21Zvvk/D4SziICEZXHyMEwGXLwLUCBlSAmRkx8=;
 b=MH60KL57hQjViQJP+jQuGAnKeO9QWh73K9YM9rrNaywkIpqo2ZOzQSBYWssiytE6BRfujo
 26gE9MNt5viYMqJBBHvNsS7zSQwLEQnIHwIXWb7pQRACSzDDzI3qo+ciA1NJQlNVmVPCro
 38eZrVEIjABiLeYtxn163vPVvAvL3IVuu/Oke6zzDBtDvna+2vtbpbvB3sIIo5g+rnrz19
 xnixWPHtKvM6rLCDkAGW/guFF7Ju7vZGujXpPGOd6n0coemzHZaR4mWrkNw031xSBI4gr6
 lUxuRL2KBIDGZvp/a60Tu7M4l8SLGknP+R8KmFrKD8wrcsDxxcMRQe49uBCprw==
Message-ID: <44ed9939-5067-4af3-9557-4cb2f6836422@mailbox.org>
Date: Mon, 26 Oct 2026 23:49:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: lwip: Split do_tftpb() into command line parser
 and loop
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
 <20261026212853.453191-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261026212853.453191-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 81xpki9mj3eu4gtrpem35rxrbymuykjg
X-MBO-RS-ID: 639c44a4bd0b05a128e
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 10:28 PM, Marek Vasut wrote:

[...]

> +	ret = do_tftpb_raw(laddr, fname, server_ip, server_port, TFTP_TIMEOUT_MSECS);
>   
> -	if (!fname) {
> -		log_err("error: no file name\n");
> -		ret = CMD_RET_FAILURE;
> -		goto out;
> -	}
> +	if (arg != net_boot_file_name)
> +		free(arg);
>   
> -	if (!laddr) {
> -		log_err("error: no load address\n");
> -		ret = CMD_RET_FAILURE;
> -		goto out;
> -	}
> +	if (ret)
> +		return ret;
>   
> -	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT)) {
> -		ret = CMD_RET_FAILURE;
> -		goto out;
> -	}
> +	image_load_addr = laddr;
>   
> -	if (tftp_loop(&net, laddr, fname, srvip, port, TFTP_TIMEOUT_MSECS) < 0)
> -		ret = CMD_RET_FAILURE;
> -	else
> -		image_load_addr = laddr;
> -out:
> -	net_lwip_stop(&net);
> -	if (arg != net_boot_file_name)
> -		free(arg);
>   	return ret;
>   }

The error handling here has to be done slightly differently to pass tests:

"
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index a49d5a72852..97f6ca7d01a 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -548,9 +548,9 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int 
argc, char *const argv[])
  		free(arg);

  	if (ret)
-		return ret;
+		return CMD_RET_FAILURE;

  	image_load_addr = laddr;

-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
  }
"

I'll send a V2 in a few days.
