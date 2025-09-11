Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B516DCAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C8B83327;
	Thu, 11 Sep 2025 14:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="mn8egkhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFF8832FE; Thu, 11 Sep 2025 11:25:44 +0200 (CEST)
Received: from send37.i.mail.ru (send37.i.mail.ru [89.221.237.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF06832F0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
 References:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc
 :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=vZecG7noZMDBuDXJUqP6H7LW7fkSF6+GMUJMdQxioSs=; t=1757582741; x=1757672741; 
 b=mn8egkhEKLCmhNzt/RDiaRT/wVUK4VTWDJqPiksEQL9P/eT+CvD/w1thF9zEXNibYbhDFjwY2Xt
 O2AdsB2Qt2iSP/b90XDDITVapMvg0D3t8PFtQHKh2ZA483l9/8XRs5nC1enGV/sDaBU1h0Q7s9iEi
 KuRte9aFtaLPlKFEbuj/Af4x52LEwceKEoat30E6gQ5cpHN/Xia17HJJkdcA7GYx8JCn99dDGBIIG
 goNcvQ6lFlfrbPN+u/Ixx2weStCcZ+81I4opaq/1phJtmzYJCDFnAaVeA4qSzFw+akZySfDSz1uCG
 hK7org+RaDzRG0QF2aqbRjqKviRX+kxmUtsg==;
Received: by exim-smtp-6658775494-qf5wb with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1uwdYi-00000000Rli-0KIh; Thu, 11 Sep 2025 12:25:40 +0300
Message-ID: <ae5ef9ce-0775-485c-a5cc-7b2c1b5cf504@inbox.ru>
Date: Thu, 11 Sep 2025 12:25:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clk: scmi: add compatibility for clock version 3.0
 and onwards
To: d-gole@ti.com, Kamlesh Gurudasani <kamlesh@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20250909101806.bymqunywxu6pe33o () lcpd911>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20250909101806.bymqunywxu6pe33o () lcpd911>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-6658775494-qf5wb;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD99F281FB5F96F126D1D78C9F8339A09AFA818CDFD58BC168C00894C459B0CD1B94B0C651943CCA83703AAE3001806DF10013EB5816060ECD513E002E59C98339D4DF7BC4678047644
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE763424119D34F5CBFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A5F354E88FC47EC0378210DB3ABFC5D17537EAA211D553AD7897D3758C1A3D2C8EEF46B7454FC60B9742502CCDD46D0D706E30CA52318619F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249D07623A0E6354027CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0998E19D2343267C68941B15DA834481F9449624AB7ADAF372E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3335407143AA9223635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A569516B0480CDF9385002B1117B3ED6964045465F07FFF5318B25839F35DFE037823CB91A9FED034534781492E4B8EEADC3194D76C41E9723BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFCCC49867F25D207E75BC527DF7FB2A41DA3F1768BCF4E06D076ADC8B5BA1ABB766971B16C155F0C903AE5C37BC66C629875035E886D61429B9C974133B43E5F9A450237FBAE9AA81034D55ECCE8C67C6913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVdVMtzNxwZu5k5Rn5lzT/+o=
X-Mailru-Sender: 689FA8AB762F7393FE9E42A757851DB694222BAECF044A144992B9652A4E83642A4DFB4EC1943DF290DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

09.09.2025 13:30, Dhruva Gole wrote:
> On Aug 25, 2025 at 16:49:30 +0300, Maxim Kochetkov wrote:
>> 19.08.2025 10:33, Kamlesh Gurudasani wrote:
>>> Clock version 3.0 specified in ARM SCMI Platform design document
>>> v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.
>>>
>>> The SCMI server with clock version 3.0 rejects the message if
>>> they don't have this field.
>>>
>>> Add support so that both SCMI server with clock version 2.0 and 3.0
>>> can be handled.
>>>
>>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>> ---
>>>    drivers/clk/clk_scmi.c   | 43 ++++++++++++++++++++++++++++++-------------
>>>    include/scmi_protocols.h |  6 ++++++
>>>    2 files changed, 36 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>>> index 83ea7bb4286..b33cc05685d 100644
>>> --- a/drivers/clk/clk_scmi.c
>>> +++ b/drivers/clk/clk_scmi.c
>>> @@ -131,19 +131,36 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
>>>    static int scmi_clk_gate(struct clk *clk, int enable)
>>>    {
>>> -	struct scmi_clk_state_in in = {
>>> -		.clock_id = clk_get_id(clk),
>>> -		.attributes = enable,
>>> -	};
>>> +	struct scmi_clock_priv *priv = dev_get_priv(clk->dev);
>>
>> struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
>>
> 
> Could you elaborate?
> I think clk->dev should be fine, similar to other instances in the same
> file. Maybe I am missing something?

clk->dev points to hw clock device. It has no struct scmi_clock_priv 
stored in priv data. So we have to step up to parent device to get SCMI 
protocol device to get struct scmi_clock_priv to get protocol version
priv->version.


