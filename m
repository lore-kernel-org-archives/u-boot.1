Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81EAEA8105
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C3083CEE;
	Tue, 10 Feb 2026 13:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rou3SH6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA5083D0B; Tue, 10 Feb 2026 13:52:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA0E83CEA
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 13:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1671=AP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1770727968;
 bh=zbQ28k8vloiKb28BoQ5gYwcwqbJ3wHrZSvaZz1NJ3pQ=;
 b=rou3SH6O+VsEKym/U/rtfd+QnZSVMdcb7e9VCRcXSM81Na7xwZPvAKkiq5RlJRDu4kbkAs1uB
 B8iyHiLIrtk1VjPq6LaDm12/ACzqxOMnCJmuHNL9HJg1Oxd3XbiOMMwj3kPD70GwJIuK4hQwT2N
 Cb7jAOCV5TfSItHYzG6zCuUsLJh36+3it/LqpmDOA/77HA7gYqwhhW5Fv/RJPqW1EqRHWUxjQN8
 T+eUjxcG+Rom3TiHWVIMPnPnx10T18eOEtG3A5Xd25fXY5da5pBv0ObNzs2qY66z8FxP3JG77bL
 hCzWfguNmvD47Q1IZSgLyVywhRs29emF7LBQ/w6vVEew==
X-Forward-Email-ID: 698b2a1ce8cd0604c09c09c3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2bc53024-8de6-4adf-bad6-0bf9d418a0a2@kwiboo.se>
Date: Tue, 10 Feb 2026 13:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: core: Use IS_ERR_VALUE() for ref_clk rate check
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260209201415.303190-1-jonas@kwiboo.se>
 <9a23daec-39bf-4b2d-85af-820e015ec4dd@mailbox.org>
 <20260209205126.GK2603314@bill-the-cat>
 <f5dd98cd-be29-4587-8ddf-3e43fcb7a811@mailbox.org>
 <20260209225332.GA2436104@bill-the-cat>
 <f4a0bb7b-197a-42f2-b6f9-ee6012ddccd7@mailbox.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f4a0bb7b-197a-42f2-b6f9-ee6012ddccd7@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2/10/2026 11:58 AM, Marek Vasut wrote:
> On 2/9/26 11:53 PM, Tom Rini wrote:
>> On Mon, Feb 09, 2026 at 10:46:03PM +0100, Marek Vasut wrote:
>>> On 2/9/26 9:51 PM, Tom Rini wrote:
>>>> On Mon, Feb 09, 2026 at 09:35:54PM +0100, Marek Vasut wrote:
>>>>> On 2/9/26 9:14 PM, Jonas Karlman wrote:
>>>>>> clk_get_rate() in U-Boot is documented to return clock rate on success,
>>>>>> 0 for invalid clock and -ve error code for other errors. This differ
>>>>>> slightly from Linux where only >= 0 is returned from clk_get_rate().
>>>>>>
>>>>>> Some clock drivers take advantage of this difference and may return -ve
>>>>>> error code for clocks not fully supported in U-Boot.
>>>>>>
>>>>>> Use IS_ERR_VALUE() to check for an error code in addition to current
>>>>>> invalid clock check to fix broken and unpredicted behavior when clock
>>>>>> driver returns a -ve error code for the ref_clk.
>>>>>>
>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> I wonder if it would be better to fix the API discrepancy . Could you try
>>>>> that instead ?
>>>>
>>>> Which API discrepancy? clk_get_rate behaves the way it behaves
>>>> intentionally and there's some fairly long and recent threads about that
>>>> resulting from attepmts to change that.
>>> Align clk_get_rate() between U-Boot and Linux kind of discrepancy .
>>
>> That's not in the current list of options. Please look at the various
>> threads in the past 6-8 months (and some reverts about series that tried
>> this). That was my initial opinion too, FWIW.
> Can you please elaborate WHY clk_get_rate() cannot behave the same way 
> between U-Boot and Linux ? It is confusing to users and it is a source 
> of bugs, this should be fixed.

I think main issue is that U-Boot != Linux, and in U-Boot we can disable
subsystems such as CLK, and the normal U-Boot way to signal that is to
return -ENOSYS from functions, what clk_get_rate() does when disabled.

Other clk_*() related functions also differs from U-Boot and Linux, some
only exists in U-Boot, others behave differently.

Last attempt at changing clk_get_rate() behavior in U-Boot I gave a NAK
on the Rockchip driver side. I am not fully against changing behavior
of clk_get_rate(), but the driver ops should continue to work the same.
There is a difference between an unsupported and an invalid clock.

Something like below, and similar for other clk ops, could possible be
fine if someone really want to align clk_*() funcs with Linux.

Back to this patch, I will send other patches to implement the missing/
unsupported dwc3 ref clocks on Rockchip, this patch is still valid and
matches current and documented behavior for clk_get_rate() in U-Boot
and prevent lockups or crashes when ref clk is missing/unsupported.


diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 748359de287b..4603ecef82b5 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -485,6 +485,7 @@ int clk_request(struct udevice *dev, struct clk *clk)
 ulong clk_get_rate(struct clk *clk)
 {
 	const struct clk_ops *ops;
+	ulong rate;
 
 	debug("%s(clk=%p)\n", __func__, clk);
 	if (!clk_valid(clk))
@@ -492,9 +493,17 @@ ulong clk_get_rate(struct clk *clk)
 	ops = clk_dev_ops(clk->dev);
 
 	if (!ops->get_rate)
-		return -ENOSYS;
+		rate = -ENOSYS;
+	else
+		rate = ops->get_rate(clk);
+
+	if (IS_ERR_VALUE(rate)) {
+		dm_warn("clk_get_rate(clk=%p, id=%lu) failed: %ld\n",
+			clk, clk->id, (long)rate);
+		return 0;
+	}
 
-	return ops->get_rate(clk);
+	return rate;
 }
 
 struct clk *clk_get_parent(struct clk *clk)


Regards,
Jonas
