Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A1BCA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 14:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403EF8304F;
	Mon, 25 Aug 2025 16:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="YzYXoGsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C065E8307F; Mon, 25 Aug 2025 15:49:34 +0200 (CEST)
Received: from send264.i.mail.ru (send264.i.mail.ru [95.163.59.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8298082DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=aE1a3H05aKVSEGwJy5KQjI1148kKRY8hcifI6hc+DC4=; t=1756129772; x=1756219772; 
 b=YzYXoGszyNSAdfl+Ro8febSWZ8ju195LQ4i06uNxcYkN/DX50sjmgCGMVyXWIcR5pnd2TA/VwRd
 SrYyhFC90qjh5dYfwr/KcOeuifdz04Ke1aKI+uI1z0sxfnSEdyD1SgPBEEN9S47DaSMMsmrN4pKoW
 X5fuqRYACE8ABONRpwvlupZTp8uEplQeovCazqIvawDuDVoFRij03J6L5VqChOFBylndgSClZJUia
 k1JLPPOCLp5V/TSCdPQ3sJYguJ54BNi0pdnB4jCdEPNUVSp6yUUSYZZsET59GpbzAsIF5bTzjO0AC
 MvJdyzgliIEP+EQhJTsUcVBxG/mo8mTG5qSQ==;
Received: by exim-smtp-6944cbb85b-bz2qk with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1uqXZi-00000000B1z-3jeh; Mon, 25 Aug 2025 16:49:31 +0300
Message-ID: <ccf326ff-b4d3-43f0-92df-07a22bd5c60e@inbox.ru>
Date: Mon, 25 Aug 2025 16:49:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version 3.0
 and onwards
To: Kamlesh Gurudasani <kamlesh@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
References: <20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com>
 <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20250819-b4-scmi-v1-v3-2-360145076b3b@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-6944cbb85b-bz2qk;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F7647FA575010556EB3CE62DFDA153339DDCAAFD7C65029E182A05F5380850409B5E43A52C3D6E283DE06ABAFEAF670543EE5933DDD95B219E539799F905E81D11E210A9E84E14EE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE745C0EDBD94D46193EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566FA0CDBC57965D23774115853392A106CA092D237786D07F7E2BB5F966B8BC9E08EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0E8801E8C4F941C018941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6F7EC8CC465A83DA3CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB86D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7E1BCFB2C0BE3F189731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5AA10677B3DFF25F05002B1117B3ED69653EA60AF13B4ECF18B25839F35DFE037823CB91A9FED034534781492E4B8EEAD2739D626790C8313BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4BA37C5FA4023BD2AD186747C6262B20AF2ED671280AC6019C7CFEBB4D0E0C86A08A323FE4E4FE8442B2DB2C2921DC12844482C152D7DE7E88A48AD9EC923586FA73F511ABF4355B9FDC11CE098E8E5C913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVXNcwk+fZooKPvc2Y+Mj+yM=
X-Mailru-Sender: 689FA8AB762F7393FE9E42A757851DB69D2CBE67FB7810B1C52F8F6D640FAAC8AE5F78F88061344290DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Mon, 25 Aug 2025 16:29:49 +0200
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

19.08.2025 10:33, Kamlesh Gurudasani wrote:
> Clock version 3.0 specified in ARM SCMI Platform design document
> v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.
> 
> The SCMI server with clock version 3.0 rejects the message if
> they don't have this field.
> 
> Add support so that both SCMI server with clock version 2.0 and 3.0
> can be handled.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>   drivers/clk/clk_scmi.c   | 43 ++++++++++++++++++++++++++++++-------------
>   include/scmi_protocols.h |  6 ++++++
>   2 files changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index 83ea7bb4286..b33cc05685d 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -131,19 +131,36 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
>   
>   static int scmi_clk_gate(struct clk *clk, int enable)
>   {
> -	struct scmi_clk_state_in in = {
> -		.clock_id = clk_get_id(clk),
> -		.attributes = enable,
> -	};
> +	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);

struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);

>   	struct scmi_clk_state_out out;
> -	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
> -					  SCMI_CLOCK_CONFIG_SET,
> -					  in, out);
