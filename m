Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C79C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB5F340D87;
	Sun, 20 Sep 2026 15:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C92IvCZTGEJg; Sun, 20 Sep 2026 15:55:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0C9A040CE6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919750;
	b=jxWLxvL5OaKCYOcVi4gPJioEDED7s3ooKGDxPnyMX7F02mE2n5mhDzAeOpQj9kSTJfpa
	 xnJQ5fjwNMS5rDYz1Tr+Djw8LgJzsrXvMZz4L8haB6c9nqimmssilBbgA5AOS3HB2vtuv
	 gemdOEbRo0Lrc8A3n469v9lAGfu/V5hwkXm5VZbJVwy0dWUfkzuCMAERSOkdZjH2rGhyE
	 7/j4vH09LbBoxEVBjcKrhZhzMZu4KspJiiXaoj8PZ0klV58yKFGJCFWHw4zNUr/46mzRi
	 u81ItXr4uRQGZ9f6VwsaYcreDy0JMX2Dl/yl65b7r7tqvEX9gRV22gUh8QcqMJoQ5xA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919750;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iE6Yyex/8++kTrXx4cFrRj0yQnwEpk7Y/USPjXfb8fE=;
	b=A//ftM/CUsfQkxO8ksd4l1V4gW9l9AaAnC8DLz1eTLWJBEUfYbE+K+5cbBaGYjyHPUIc
	 eKOijTMJrAv5SgIou2IC/DfBHcmd0dd014/1dR6cbB9q3+mTl1akJ47xnth33+I7bAJcF
	 yQ8OEYBCl5f/h1ipK2IXMtKQ2NgYFVeEM/hHlaxiP3C/zF58Eu+WFEe0OCMGQTSoROj3h
	 PusjEl7Q/OyZaXSjna15aJfVw6kOYd0YCtj4FzewJW8+giub70mQ/PSxgLXnkoyhhdlP3
	 wwqQ1kiNjKUZdW03nJNU48cqcEQbkbdTGKE4I1w6HGDeTfThUzPMhjDt0iFFOKWkpfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919750;
	bh=iE6Yyex/8++kTrXx4cFrRj0yQnwEpk7Y/USPjXfb8fE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tNlSSmWidxm9iKwvI+knRG9ygoF0DE0og81l8DHn0nRfVv1KLFnNmJm1QaifirYBi
	 J9uPyvMe/bgG1iq4PbS9VkhD4LrRpFGMYBQUoWNBTCJrVIp39dbZsR6aDslTimU35B
	 rTLxRjIuodomh8/i1CBDckGybQDB2F2rxym3jWwIvwgpiQTBznDTi9Tcixs7FxgcCs
	 oGcEoFiEp34DC0quqbHbXBOwjVDlHOSIgf+GztT5gxZ617gIQczkaWcUUWPv4ixlzM
	 WNlLIg8s72ZVxFOxR8jsAjFvs7OhVkKujpxlTDIv/nwmzFtp+bPiBTLsl48aTzbp8w
	 7mEwyMUroi/2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C9A040CE6;
	Sun, 20 Sep 2026 15:55:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81737371
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7231360629
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cFUHZZz3dxJJ for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 15:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57FEA60603
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789919747;
 b=pwBMtHfvH4ym/sYC5OmKO3Xmg38yeKDLFb6e/cZ3HoUtE3WhfN1OLldMnA6psOHay/68
 l2nxqr+lLzuNxg9FOem+iJfLQlVviQrAg1J+Ue6Y3BVfICza2qIw1k8656v6IzfAye+4A
 p+W+vcNnXe9BiIeBJzMnDdtt8R5mrLQvOEKQeQOAbSQhGiQ07lLBE28bJKVoHIuEcdhua
 dLLrlIGie4hmxbpeUoAB3MUL4PmhIuI85yrigyIbElsp1YyZ8aBwc9r6/aJTd0TJLpqWQ
 fthdG4bt06lO9i2Fy7l39Hft5SNDq6YzX14sPoCGj4NAdu29A+n+OVTbSqMYd1E/4VQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789919747;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=iE6Yyex/8++kTrXx4cFrRj0yQnwEpk7Y/USPjXfb8fE=;
 b=Zyu3awKcs37TzW8huWWl1+0qZahqxu4XjbYcOsNeEOMTQXNGiY/Vhaki43AyOU5Qrzx8
 1FUIZVuX9OJGo430AqVqvRoJFfMIRAkF7I8ByeNd6wp2gKtdln58gINy7dVnGwlY5qHPN
 HXzIvhW/yNNTPOXK97C4jKri3tCTC3Tx6SK5RpIAOK36loQP6aDc3MPmHs44VbvR+GHM3
 W1J3TXhjNGwIyLmihTF8EqqKnYBX8L9WYNyVzTFzjIQZf0QfBJmoxrx8nkq77JBdWlvs/
 LJ8FJMi03DN6nV3C/OgnvFw3wr9yhE758fuA9W3QLalgmI1Sva2YAQMt3we56EvbbpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=su9i7WOM; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b560=hn=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=su9i7WOM
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57FEA60603
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1789919745;
 bh=iE6Yyex/8++kTrXx4cFrRj0yQnwEpk7Y/USPjXfb8fE=;
 b=su9i7WOMiVH+Naur41aMxx4CiSxI5IZ7wT01NpxMpU+ePPFRwlggEoxxgglL8jScuQllLWy8s
 SN5qojn7+gdakXURcyIaI40zz9mMzK7O8fkUPWocvttS3rTZyxdLVFpZp52ybfcbPbCEmifgwRy
 iA9dhOtjsFSNwBZwqz7cgVrFDcSnJCzh+Tv1IxuDqPv/FgdEAtv1gH4aAhg9CDUS+PLNei0Wcuw
 Wa2YYXuca9iatf6H67tpN3zpgXVI/bJO3K8FpQ6SP6WPr707NRTSivhwsxrC98JmsagtGxZah02
 SBnRdlnQuG7gfGSZQGd+rZp0SO4QZH8CXwJrIHPqtxgA==
X-Forward-Email-ID: 6ab001fd2d57afeb3b33403f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.15.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9acad374-5f44-4e58-9689-b9da211a8909@kwiboo.se>
Date: Sun, 20 Sep 2026 17:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arch: arm: rockchip: Skip needless CONFIG_TPL_BUILD
 check
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, =?UTF-8?Q?J=C3=B6rg_Sommer?=
 <joerg@jo-so.de>, Carlo Caione <ccaione@baylibre.com>,
 Alexey Charkov <alchark@gmail.com>, u-boot@lists.u-boot-project.org
References: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
 <20260908-xpl-v1-1-58e9e5248c29@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260908-xpl-v1-1-58e9e5248c29@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 9/8/2026 7:04 PM, Massimo Pegorer wrote:
> Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
> proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
> CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
> that CONFIG_TPL_BUILD is not set either, making its check needless.
> 
> Fixes: bef9fdbed2e5 ("arch: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD")
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  arch/arm/mach-rockchip/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index d3bc0689f89..8148816c48c 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -15,7 +15,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
>  
>  obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o spl_common.o
>  
> -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> +ifeq ($(CONFIG_XPL_BUILD),)

This and next patch seem to match my patch at [1] :-)

[1] https://patch.msgid.link/20260708220540.3368825-2-jonas@kwiboo.se/

Regards,
Jonas

>  
>  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
>  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> 

