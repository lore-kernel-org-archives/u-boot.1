Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653A606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0Mc/M090;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCwJgxxa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BB8A40677;
	Mon, 23 Nov 2026 09:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U8koEMs6TX6R; Mon, 23 Nov 2026 09:31:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74C5D405DF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795426304;
	b=b8yQMjv28scH3nN/GFpKx58SEoYnE02YjrGSnG2qEgJytUeKw9CoK4YV5VyMCQl0yvWN
	 JDa21vuRgD2dK8TL5wTOXT/Aqu2i1I9aBS/d1Uy3hqIG3XEHRv/jdDlnyryLovDaAlkLq
	 PUGO7Ti2FLxZYy/hWXTdo9lyVHT/oPGrKQa7cbtjtXf30PTVMFmnRJmicVb7u08EcFbPx
	 iw2MuDDrHgWNVjSnofh5wHPctvX8e2VXmitB6icBbGKuUF/qJnsH5VPok39sQhCbfk3Qj
	 OB1vZ09qzrFbShwgmZogCvKynSCGV3s38lxMf4Sm8WEg2XMcxa4vvNHMIkZD3omhySg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795426304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PS0IrWfMmbvY26dIpYGq+QgyoU+judQY6dGCnfyySJQ=;
	b=Q8vKjFirGWfwtjrav7dqr2c8TvjZFjsdGgpe3rDb4qMFzhbHkLh7Ay2FmJpZj7U9ZYZ5
	 0gq4f/B2bZhDdcCL6KCs+vPltklS10ir1JoisyZF7IObaN5qB79jxKiEw5rGke/qwZSEv
	 V+21CzBa9EY8/7ZS7spPIh+EgQrkgXon014uSuKY4zHCfqu4seBGyv/kFKKMcuLEeMonF
	 FmXzNbOjYMkecj3Wmnj0Bf8eRmVZDFDCe7LmiqT9vD6Y44xIe2Z0QV0eW7ObbwlZhgTRx
	 LmiMw6Lr6gmnPYQFtXOa69n9BwmzsFx+Knn9PbXNPZIb06oIr6v2DqOoj4qpGeQV5pw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCwJgxxa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795426304;
	bh=PS0IrWfMmbvY26dIpYGq+QgyoU+judQY6dGCnfyySJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Mc/M090VR00rdmcaxUYjxtUOfu0HntkHAWfoEKvMTWr0Oq0PUbdfwy7OBAsk42Wu
	 YbgmsWMbE5FMvBlxZULQIvUvQLfs4xin+YL4RmxtxDw6756RU0UYvWWQuwsY+RB4Iz
	 jjvDojfCNo8PM6L9IT9GGxq9T9Lz5CWzfaInij8Ma4El9kAUIU7c9Z366xlwzxF1KQ
	 dNmAlBQh7s90/tvzKwyTwnHChrXSoK9Revaa/8ybfedVkPBVHgMOhh1cRV38c3tzwc
	 6wDoSv9pujAsbGBbaCogUHuUWRYJeZioAj73fqY84iH+n6r3O/W+MHV5As5F6q0Va/
	 Ir9M1C6G6opyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74C5D405DF;
	Mon, 23 Nov 2026 09:31:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89FB41AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B527405DF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:31:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBxyixhrK45D for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4BBA4405AD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QCwJgxxa
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BBA4405AD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:31:40 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso35644375e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795426299; x=1796031099;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PS0IrWfMmbvY26dIpYGq+QgyoU+judQY6dGCnfyySJQ=;
 b=QCwJgxxa6pcgFPJiMX0TsdQofpVUpcyu/64Id2NSxFPVh1x+8TYCyMDMwlqkFQiaYs
 M/U4SDdwu/erQiAIr3bOb/08NZo7T1BZZP2ZWdeY8laqdY3jsLmlfvrVOqDLLoZW8OY1
 o+Im2bqJ/BX34D2e1JBnOhBQ85Au6x0VFOPu57I1vC4UQpGA6dY+3pH+QVs9Pz3Z+OIh
 THK55hkha8UlLPM+bNCxb1QdfIDamvINVqjM4EK9Q6fiMuLFHg602xSwMqeged1WHeVb
 VVHIsXE3juH4dcfEFK0zbrRDJaVTGBcVW8SgxYn/up480qlimq02+u2F2ZyybCJ+x9HR
 axhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795426299; x=1796031099;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PS0IrWfMmbvY26dIpYGq+QgyoU+judQY6dGCnfyySJQ=;
 b=EdEE9HyNi4WQZD7hjgr9D6TDtPU5hGykaoJ38E39S746RNz/w57kulRyuJ20OeeasB
 2rcr9jm9pSnMNhjTI9R1blEQWDVi86Vm7i1UU11WktBB3f63N2C7Ut7gp7esTuZkWTpS
 oInbV3dVboZQEx81qRSWtYMC1c8UZ2N5KTTBLpGPOMDiMkc9KvScqHjwh6B11SRw8SLh
 gN6od0l1fbnN1Z7wOTzR9ZuEHpaQBJ5d0MTCVveh17F2CG+soWofbL8N46hE0DZ4QxCS
 EFf7vD0N/x0mtEXrMotNeGNXU2ozeP/uhZBufPJpT5sCeLT11E1IOJpRMUM+SabyKsOs
 ATFg==
X-Forwarded-Encrypted: i=1;
 AL+hErGJ9JfFUHjSbsZ5kK3rdQId20cCQfg6e1ywDmWU7O0U5/JZAWjFRM/c5FhcARpSNYdfMnv6C5E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8L1KFzWMgQdwiq0D9oS7EgsSWfWvf4YtOYO/VePPzHauOpIzAw
 Xrhe3Dv3OaMC33zHDl3ahvw+2UGtZOAqnvIZvy5J5AbWNOUYddm3bTZM
X-Gm-Gg: AZFdTZdcu9l0T10OFVT9EtCNSo7a1MWLGUCaQjpKo+ndndX6M4zwOeDvnIdpbuo5blz
 i97XReU86UZOLGlcMbi0oW+JvIOORbfTxFALlzBcDE65gM24RSMLUESIMnq04jEm00CW3upZPD8
 fAku2DegB/La7yDfRga+u6wY+4i2muT5PTxiTc+eqQEk5Onno8EU89dwNoRFGzNQZLCc49DSQeo
 ZqZ3ZkNHTZX0GFujB4oY3AUtDDgnTHiV5vu1FoNd/O+EXuU1skuIdZmWIF+VfHBwoysvX4J6bv0
 r/Zgcd7kybuMbKUHgAfBS8KMRg4aQlJ7R37vXuBgWiAA4mhE14vRtV/vsb1Hm3QmGKytRkHLSD5
 FDYTr4akk1IHPCF55w7CB43A8OrtubxoZFkG0/uey6DxjA6UEuKCtigKXh8TbblETuMlMhbiNrT
 nsJWgPpSmp+O/ZC+z+TY5QUq9ugp/TTGRGjPucFJUniH9+U29xDJSFfq1fl1vy1HKkK0kA+TOB5
 XW58t3fDGpeO6mG0VQjR+w4fzywHfIsK5eNrutWm4IE49Sy3L6VcCkCLbgVcAyJQAGQbrhGZiXf
 OQLL8APpN6M1SEGCVy7JuBUaXaih40cfBqf1xZNNdVdcJN3SgbtrtAQeVMXUveD76CWwYzX9dhE
 mSFiUUY8=
X-Received: by 2002:a05:600c:4f53:b0:4bb:68cc:7b94 with SMTP id
 5b1f17b1804b1-4bb8616516cmr299687805e9.18.1795426298884; 
 Mon, 23 Nov 2026 01:31:38 -0800 (PST)
Received: from [192.168.68.89] (host-87-4-46-207.retail.telecomitalia.it.
 [87.4.46.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm19645716f8f.34.2026.11.23.01.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 01:31:38 -0800 (PST)
Message-ID: <a8b913ab-e298-4d42-9b46-e97fcc33e35a@gmail.com>
Date: Mon, 23 Nov 2026 10:31:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: ehci-mx6: look up the port number with the usbphy
 alias
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
References: <20261122195302.GA432275@francesco-nb>
 <20261122205141.748487-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20261122205141.748487-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/22/26 21:51, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> mx6_parse_dt_addrs() takes the port number from the alias of the USB
> PHY node, but looks it up with the uclass name "usb" as the stem. The
> PHY nodes only have the aliases usbphy0 and usbphy1, which matched
> only while fdtdec_get_alias_seq() accepted any alias starting with the
> stem. Since that was fixed, the lookup returns -ENOENT and the probe
> fails on i.MX6 without CONFIG_PHY, host and gadget alike.
> 
> Look the alias up with the "usbphy" stem.
> 
> Fixes: 74b14db48a8e ("fdtdec: match an alias to its stem only when the number follows it")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/u-boot/20261122195302.GA432275@francesco-nb/
> Suggested-by: Francesco Dolcini <francesco@dolcini.it>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
>  drivers/usb/host/ehci-mx6.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index 25907f22612..93b0d75633f 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -609,8 +609,7 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
>  #if defined(CONFIG_MX6)
>  	int anatop_off, ret, devnump;
>  
> -	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name,
> -				   phy_off, &devnump);
> +	ret = fdtdec_get_alias_seq(blob, "usbphy", phy_off, &devnump);
>  	if (ret < 0)
>  		return ret;
>  	priv->portnr = devnump;

Tested on Apalis iMX6Q 1GB with the configuration we normally use to load
U-Boot over USB:

CONFIG_BOOTCOMMAND="fastboot usb 0"
# CONFIG_CMD_USB_SDP is not set
CONFIG_DEVICE_TREE_INCLUDES="toradex-recovery-u-boot.dtsi"
CONFIG_ENV_IMPORT_FDT=y
# CONFIG_ENV_IS_IN_MMC is not set
# CONFIG_ENV_IS_IN_NAND is not set
CONFIG_ENV_IS_NOWHERE=y
# CONFIG_TDX_CFG_BLOCK_USB_GADGET_PID is not set

Without the patch, fastboot fails to start:

Hit any key to stop autoboot: 0
g_dnl_register: failed!, error: -2
Apalis iMX6 #

With the patch applied, it works as expected.
Base: e578056c766d ("Merge branch 'main' of
https://git.u-boot-project.org/u-boot/custodians/u-boot-sh")

Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
