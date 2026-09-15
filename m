Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09F4C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A85980AA0;
	Tue, 15 Sep 2026 15:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbUKjcB0hxcM; Tue, 15 Sep 2026 15:52:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7DB3E80BCD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789487524;
	b=gSTW8TZAv25IJCRY2wRFt9QuvwDnASzBBy7X/YHJMbHIBDu1hhXaxiuxnic6odc9js8g
	 KlWZULN4mpL4rgMFRZvIs9jeo9mEQchLWq4HfuHAbeJWhCbiqeMni4tx1HbYhRK0wkof6
	 LTkBkMhJSjfVV3h6DUW/2hl7IeIsPU0dZRZNsD+gDLLEk1etCE06oTeh0LzZHd4/ZuiH1
	 /OIHau52WceG1DCFHOHXEWCGx1+WdMHMtLBDk8OqjAOEBUyDc6aImbZd3ENFdzzEM3CT3
	 XD8QSNXQ6zpoCPbAGLHrJPu3vy6vygEOdMwi+JUoOFQCv0vMr5JkffOa8iRe8Nq83zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789487524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZEWPnSOSUJJMwUJDOin57im4n/SmgLw/K745xZnCrbs=;
	b=LgNNytcmBlzN2N4JqPVwwHglMzDWkB35UhyH9FSWqdxk6ZwuQKB3VbOv4j/rdAuCyJVB
	 l4pZjkVgax3uGO7Y0s5g5CMcL8lgg1/wg53bk+ksANkoTP2pBQ9d9Qr8gih+RvMcvPijX
	 x/tdL98Xz+Xsen8sCPitTPsP39XTdAoQJZIPq2WuBmog9qa1XpyR13l3832MMaxmg87vN
	 TWHgotN7Gs3RKbtYPECg+KOQ43iMMBjBd9wyQQHoocK0/Zzn4WA/oxG1AUdh4/XbHRvY2
	 5aJTj9UBHG0p9DBbU1s78sqPOqq1p+UkDavzVdT5zLZj/k5qenchjTDIJqn72E0aJng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789487524;
	bh=ZEWPnSOSUJJMwUJDOin57im4n/SmgLw/K745xZnCrbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUCp14yqteJAkx4GF8bZw/5qrRf0QytZhUpSiE47MCvzCDXtliik4Y/0nWzidvywS
	 GL3SE1iFpQwAkIULS8d/TG8bLYRT4QO3AE9iAHuZVkK6p5YMuAj1djJ7/R3O2QBLba
	 HDkp6rRn5Z1WkbR5Op8CLfQVpVAqkDCshtpqJxJk/poNhZ8jzLP/84DasrBSHqAe7m
	 w0kIU1NounuDDTDCGRsTkQXoRtpDjwTCTIUx6VcqjpsKQmcvpbinb5MWqn4AKxuCUb
	 +AEtNeWNgITE34mSfP7PzIHUCtvj7JpjPXyHpHbAja0qdf55yh8VEAfR1MFChntyeZ
	 m51Es37PGRtXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DB3E80BCD;
	Tue, 15 Sep 2026 15:52:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79C24259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 07:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B7906072A
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 07:44:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOS0vRB8xzQq for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 07:44:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 639F8605E1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789458275;
 b=Mh+yypLkj9bI01huDdtoAlF8qZ0G1+5sC0n5MwNMHH/msPdXqAItNUli5Obhq1NMpDUO
 UAHFLuM9/mhDVJ5TyVC0RC0HJFlEfjrF+AQyRk8hnyL1ANK6Lj7m5sZp5oslNd6Xe9ZO3
 uH7/IQpXz1+q2TedfeSkWqwGP+ueq5pq3NOgbXXt6R9ofc1/MiotEo5X5s3arxYcgdcwt
 2pP8eKx4eyh0PVbUcuYxREzVgQEFRbYucLLOOUjN0NK2zyMOCYGoG8ob1ibXmKBdNBt1b
 MerLFkmhn2xT6Kja9P3RUzrkrZgdI655zsOtc37cqnECV0y9NzmmvK7y+2eicL3++8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789458275;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=ZEWPnSOSUJJMwUJDOin57im4n/SmgLw/K745xZnCrbs=;
 b=S/cZX0U8TzdcULjrKgS+ZuGVWZb4V4imS6TkKqSIVh0JRFvEkzSU+zMmbVOJo7mq6XeJ
 qHQ6ObrVDEkqRyYDCoW+2STogfWf5ouNW72IEC40K2Wgz6mbwziC2r6FO8zTG4p526jcs
 fd8qnM1MqswH4Id6vJNa5aHXLV9bLtZEC3QokZpy87frQOBZ13+/1BQyE36wrClLPNKzJ
 rGF2Ju0J3kR61/LJ79XVUC6mAnvCagcG41RcRu7M8awsJmWUSLjETTXt/LOyv6OiRNs7H
 LQpaZPw/2yUK13/lJHteOGIOOl1AE8Gj05kHvRBmzTslkHisZg5+ODKCiY2F8YdryDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iw3NbpOv; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iw3NbpOv
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 639F8605E1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 07:44:34 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350faaso1380382f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789458273; x=1790063073;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZEWPnSOSUJJMwUJDOin57im4n/SmgLw/K745xZnCrbs=;
 b=iw3NbpOvA/2854YXLtV2JWzs1vvNdWKCPXfw05KQn2jNujl+Unh1R+gGXgPUTz2oVc
 rW3+EPo6TGcC4+SWFjWFGELzXbj7xJrcC8qvdgBPnIzHRXYAypXacX6slWiY4b05LMOh
 PrfkkqZU9SqSytTRyRi4FpglvZ5+BxCF0k/xXP5HzFrrTBBqBBKT7KFPyryWp8bfPCFI
 9zv78cWbm+iMLIGF4Ig7SPD71RxkfXa6fjWsjd8+5V1KLhVm4mdQdn/mO07LhZpwXarX
 GmwxzFq+/RMbX3Qb9OsoP6nSfQeMR+f23sVi3eb65rvFqsGteSTZT+q529jqA1yHGu0s
 UJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789458273; x=1790063073;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZEWPnSOSUJJMwUJDOin57im4n/SmgLw/K745xZnCrbs=;
 b=IIa/fYmTf+POc9OBEgp/zeTR6q0phZOYkdKNG4/+lFashunagObyLyd53OqHfGcr53
 6Xl6XTS/Wk+qXrGdp6AAm9hknR/fOwKMObJDCu81Oj2kHJMPSEjvoescwr9OooeJdo+Q
 LKVOJlT5SXzL4vAu7ky3C0+bXKRXH72BHMmLhTm/Rz6xd47I9dxUn4+JY7aFTd/03Hz/
 9jyiqt0Y1TvzKY3sePjf3dbdqgVzwf6tPVmS3a0gjpKjW6T/swddBMCdWAKluOSsXkeS
 g/grf1y0OmrKNSGMnQR4hjREEFQOl04H/xmatyLv9QRjFYxElb1JAr9xEkzWASC1BpXN
 Do8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlH42tHK8F/d9pH6/83VWrhDl9mcZ5U6eYb3tQWBBOl5bUSIums+MLjrRHTOWSy6RusQRtDko=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nNodPvYHHaODhTsmAanhmDMI/VkWHglXTUgtRRIetjjgt2IW38
 tt0obmTiZIbhNPm3p4AL044NWlUUd4373lHqykJ9cs9/jlED/o2HwDu+
X-Gm-Gg: AYBFou3/i719Z9wNZpUrjgJJRzMo1DskGn1VnXzA1PykNh5jKZnQABxBU7uAwZFU6AA
 FHgG2kL31iqZaJ/H8SCE+XKMh1qQ4uGA1fOB7zowTYLYCGw6v8hOOfnZekO/BdKJJe3JltGUETv
 MCDOTKWD3YiOEA3E3QnvlylcQSUWOQhkBGamgFuj0F+N6nw9l9NRMK5Wf9ujC2CujnOonehRW0m
 8qVqaUCSeOOAhktlctp9uLDRstFZC+aBWdMhVntqBb4JgotMRPvdG+nXeVWExjmICSfIxQra0cX
 xwUCxA1aUd/PJV2Qabs1THzplR1g7BHuDye7bvJM0BWo/JLkT0i8zSevBL6eVLIEaZ3dbONab/A
 ANF+WYWiM2jahSx0e84eRwLxWXDyoRNoo4fJMWc/d2cKXzv5GIG7Bx45IhsfshHvvpi1/8OIX5l
 OlbPsiNktqpHQdKk/XU5be+iZ6uQjDqn8S7T1Gd/5MvPXqY81Ug583FugCRGzKszjKkqTxcXw=
X-Received: by 2002:a05:6000:4b18:b0:487:95a:db58 with SMTP id
 ffacd0b85a97d-487095adb78mr759792f8f.55.1789458272413; 
 Tue, 15 Sep 2026 00:44:32 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f301121asm27261519f8f.0.2026.09.15.00.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:44:31 -0700 (PDT)
Date: Tue, 15 Sep 2026 09:44:29 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 lukma@denx.de, mkorpershoek@kernel.org, antoine.gouby@toradex.com,
 alice.guo@nxp.com, stefan.eichenberger@toradex.com,
 sjg@chromium.org, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, pbrobinson@gmail.com,
 quentin.schulz@cherry.de, jbx6244@gmail.com, ye.li@nxp.com,
 xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 3/7] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
Message-ID: <aqj3XczDvnQs0Wwp@eichest-laptop>
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-4-eichest@gmail.com>
 <94548efb-5bb8-4320-82ea-5e40b706d584@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94548efb-5bb8-4320-82ea-5e40b706d584@mailbox.org>
X-Mailman-Approved-At: Tue, 15 Sep 2026 15:52:02 +0000
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

On Mon, Sep 14, 2026 at 09:26:12PM +0200, Marek Vasut wrote:
> On 9/14/26 9:42 AM, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
> > port the hub itself enumerates fine but a USB stick plugged into it
> > fails intermittently:
> > 
> >    Verdin iMX95 # usb start
> >    starting USB...
> >    USB XHCI 1.10
> >    Device not responding to set address.
> > 
> >          USB device not accepting new address (error=80000000)
> >    Bus usb@4c100000: 2 USB Device(s) found
> >           scanning usb for storage devices... 0 Storage Device(s) found
> >    Verdin iMX95 # usb reset
> >    resetting USB...
> >    USB XHCI 1.10
> >    WARN endpoint is halted
> >    WARN endpoint is halted
> >    unable to get device descriptor (error=-22)
> > 
> > Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
> > both controller DT nodes") added a fallback that searches the DWC3
> > child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
> > the parent glue node, but always resolves the found index against
> > glue->clks, a clk_bulk populated only from the parent glue node's own
> > clock-names list. This is wrong since the child node's clock-names list
> > is not guaranteed to be in the same order as the parent's, and indeed on
> > Verdin iMX95 the child node has a different order than the parent node.
> > 
> > Fix it by looking the reference clock up by name with clk_get_by_name(),
> > walking the dwc3 device first and then its parent glue device, so the
> > clock is always resolved through the device that owns the node its name
> > was found in. Also enable the clock before use, the child node's clocks
> > are not part of the glue node's clk_bulk and are therefore not enabled
> > by dwc3_glue_clk_init(), and disable it again in dwc3_generic_remove()
> > to keep the enable balanced.
> > 
> > Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >   drivers/usb/dwc3/dwc3-generic.c | 47 ++++++++++++++++++++++-----------
> >   1 file changed, 31 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> > index 2356b3bc0aa..704dd242553 100644
> > --- a/drivers/usb/dwc3/dwc3-generic.c
> > +++ b/drivers/usb/dwc3/dwc3-generic.c
> > @@ -31,6 +31,7 @@ struct dwc3_generic_priv {
> >   	struct dwc3 dwc3;
> >   	struct phy_bulk phys;
> >   	struct gpio_desc *ulpi_reset;
> > +	struct clk ref_clk;
> >   };
> >   struct dwc3_generic_host_priv {
> > @@ -47,8 +48,8 @@ static int dwc3_generic_probe(struct udevice *dev,
> >   	struct dwc3_generic_plat *plat = dev_get_plat(dev);
> >   	struct dwc3 *dwc3 = &priv->dwc3;
> >   	struct dwc3_glue_data *glue = dev_get_plat(dev->parent);
> > -	int __maybe_unused index;
> > -	ofnode __maybe_unused node;
> > +	struct udevice * const __maybe_unused clk_devs[] = { dev, dev->parent };
> > +	int __maybe_unused i;
> >   	dwc3->dev = dev;
> >   	dwc3->maximum_speed = plat->maximum_speed;
> > @@ -63,22 +64,31 @@ static int dwc3_generic_probe(struct udevice *dev,
> >   	 * - in top level generic node, with no subnode (i.MX8MQ)
> >   	 * - in generic subnode, with other clock in top level node (i.MX8MP)
> >   	 * - in both top level node and generic subnode (Rockchip)
> > -	 * Cover all the possibilities here by looking into both nodes, start
> > -	 * with the top level node as that seems to be used in majority of DTs
> > -	 * to reference the clock.
> > +	 * Cover all the possibilities here by looking into both nodes, the
> > +	 * generic node first and the top level glue node second. The clock
> > +	 * must be looked up on the device that owns the node it is described
> > +	 * in, the clock-names lists of the two nodes are unrelated (e.g. on
> > +	 * i.MX95 the glue node has "hsio", "suspend" while the generic
> > +	 * subnode has "bus_early", "ref", "suspend").
> >   	 */
> > -	node = dev_ofnode(dev->parent);
> > -	index = ofnode_stringlist_search(node, "clock-names", "ref");
> > -	if (index < 0)
> > -		index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
> > -	if (index < 0) {
> > -		node = dev_ofnode(dev);
> > -		index = ofnode_stringlist_search(node, "clock-names", "ref");
> > -		if (index < 0)
> > -			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
> > +	for (i = 0; i < ARRAY_SIZE(clk_devs); i++) {
> 
> Do we need a loop for two device pointers, where we are basically sure that
> there won't ever be any more device pointers in the list ? (I think no, so
> please use four clk_get_by_name() calls and be done with it)
> 
> Also, please send this patch separately, so it can be picked as a bugfix for
> 2026.10 .
> 
> Thank you.

My fault, I somehow missunderstood the last comment and thought I should
create a loop. I will change that and send it as a separate patch.

Thanks for the review.
Stefan
