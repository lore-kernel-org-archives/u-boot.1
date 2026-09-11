Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF91FC88E56
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F691605EF;
	Fri, 11 Sep 2026 12:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0F_ZV5VzNlLS; Fri, 11 Sep 2026 12:18:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BFBCD60662
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789129086;
	b=Ga+NY1BZzbSpiNu5/xK4uU5o2iBiifc7eQgImzJ2unZNwLX63FtK46Yx4nFk032+h93n
	 DgC7nCD/VhIl3bwjMrKhT69gEE8DKCNydX9SmJoSsQbTPOxhC4kWJh1yLI5jL1fHH+sLu
	 /nXwQBqQAY+FV+mS5WOf/5l6ifh0gja/kkrPnYFO4L+PoDOCIrhbVbMyn0PhYa2I8pDLC
	 dy6w97Q4sCUoONcXD5PlnSNgypeMnrEpbMwacox5Q/01AdxMJg+ihNRQBxPOac/A1fFWV
	 oEbpB6RRks4n67rOXe+zd4gLdByphQBpcrD9u0ug3gUNP127HNK/HgIu3RVvonIR9WQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789129086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r2HDr9H9uh1WLdOR6otY3BJ64jPvi6iPgDiiRWyH+EU=;
	b=BtdmODTbPzYbp03MtjliBz6QdYPar03J440BsgGNQ6w23dTOxiVgFhDyaT5kYvid7Kv+
	 +9d9k1UjJjxmD6+qE1JDEAFvQJyyCRewxWs2CMCMNYfpaf4BTA6UWTZavg3w2l3GtgHE7
	 vyPTQUQMOI31O6BPYKz5s4JvtPte3khhVNHRfTYAOkmTqTNMGx/GRvODSsdMgU9SLENZt
	 pQvNpy/n6tn1MAiD2ImcbrbK505P0un+15k8D5MSG5f86ipfAb58PIi6vMRqRtMpUxkAp
	 F9/gawERmC19SHkfXiOoBUpvZ9MuBsOrTb+Tvm8SCfBRhAhKkUEw31TXWW4Am3g5cBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP2Ge+IJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789129085;
	bh=r2HDr9H9uh1WLdOR6otY3BJ64jPvi6iPgDiiRWyH+EU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gaSW6u9TSbS+0Z3/HKig4Eg2rgxx69xyJ5YavFpKplVQ7bcR9GV535SL7jWXLYB9+
	 U1c9HHGojG9pBdRRJltp8ekCAihNioEmGqD3IeMPTU5oS1rRkAkErqKv2EqZuBjS9D
	 H5Zeye8k4fCSUXqo2Y100bbX26BNKdGPwllYUdicM8CfHPCH62A/C7GDd1qSOlc/rW
	 gWNitvHOP5KgEt7Gsk7phxT6O9dPtbTAwQUujztmATJCfA54XQrCqhamVpytsE6c8f
	 h726gzHfjddl59beY7/1JHOwUanNTn4RtpuD57mCKSFUWcsSyzMxw7kd4gjlgDraT9
	 z/xJ3snPb0ftA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFBCD60662;
	Fri, 11 Sep 2026 12:18:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6E0E2E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC1DE60662
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:18:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aanju79pfWCN for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:18:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0004E605EF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789129084;
 b=CppbS/T6CtIdcSHt5fvo+bQC8MxJ4tCyOeZHFKlJYiXtwRDIDKIqI76zAAskOuNQehOb
 2RXp3q2m404pbGeoWNdZxXSkMB403o7mZcxrQfaAYNijv+gE2OiCnO1wx6dcIvZO4JNTg
 W64guyNTanLlvrsJTa9OqA/JQwE+Solb1T5y2YZTGfXkQnYKh6O/UfZCAq79/4N07m33j
 0Z1hlLLVBIIpnpI7D1DX1e8IwNykdmjYrc9L74ux8Ezvi4scE1eqRBJamct+qCVncNx+N
 bBLT/OQEQZXEwPDricH4TiKogi0TH0GSOlVclcccNeqQGeuOoFXGTyRv5Qh1aecOU/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789129084;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=r2HDr9H9uh1WLdOR6otY3BJ64jPvi6iPgDiiRWyH+EU=;
 b=IxQkCnk2ePDAFgAty45dv1/ZOH8E/0uRz63MfaIRI+CPzfq7P8dwWkVk5P0nBtywE+a8
 U7h4+OPTk4+kuSgGsYvfO/RrK3sxyXB7dY8nd1Wf2/520WJIG3bMpTukw1FDWGxdHDvLJ
 3gu58+nevxe1R94Ix5BgIfc2gBYrh7tqVPoQ3cG7IS6aPPLrE5wHVbL4+y8E7Bd4ZZSSL
 8U/w/WG9fj4kbvvNkMu+Or1mpSKOQ897c8+cMOdqr3FM2h9Gk8b2ipFKCdKp/yUjSiTT+
 HZmiT7+aC9GbHzbs2Wm+z+yniMcpjS2DJtU3jZ2g3duGP1fG+Xmn3lscLvcDNjHqm4w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UP2Ge+IJ; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UP2Ge+IJ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0004E605EF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:18:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C19660A62;
 Fri, 11 Sep 2026 12:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1801F0089B;
 Fri, 11 Sep 2026 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789129080;
 bh=r2HDr9H9uh1WLdOR6otY3BJ64jPvi6iPgDiiRWyH+EU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UP2Ge+IJBuX5ST8MwO7JCglB/yfoQwdIKlDRf/2ptdsi7T/+FbZ5xTCS6K/AuxMYB
 fq8674EnJQ/soJmTcSTTK8g1GxK0eTLqChkmgQy2IXow8lT533ERw/OhNDUae4+Bym
 m3SCWhsuZ0nxf5sVOAf84wqm/ASxNJMPjKnP86zVToZmYImyBvFXykw1wEYG5mfypq
 bI8fyYKXIxgwYBeLLUGAHCBln1xLTZqtmakJ5eLOTlops13Akq8Ft+xJHF54yBNF0o
 h1Nd+7z2F/iKJOKI3bq3jKIOHGvzmgw/lKIFCbpXHWYM4y4zQP/okGxFrCxznALgSO
 kRREMih/Ltd+Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com, dlechner@baylibre.com,
 anshuld@ti.com, sjg@chromium.org, Anders Roxell
 <anders.roxell@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v7 02/24] usb: phy: add the usb_phy helpers needed by
 the resynced DWC3 code
In-Reply-To: <20260824154133.217744-3-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
 <20260824154133.217744-3-anders.roxell@linaro.org>
Date: Fri, 11 Sep 2026 14:17:58 +0200
Message-ID: <xhkdbld983rt5.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Anders,

Thank you for the patch.

On Mon, Aug 24, 2026 at 17:41, Anders Roxell <anders.roxell@linaro.org> wrote:

> The resynced DWC3 core includes linux/usb/phy.h and uses struct usb_phy,
> usb_phy_init(), usb_phy_shutdown(), usb_phy_set_power() and
> usb_phy_set_suspend(). u-boot has none of them.

Nit: u-boot -> U-Boot

>
> Add a cut down version of include/linux/usb/phy.h from Linux v6.16. Only
> the parts the DWC3 core needs are here.
>
> usb_phy_set_suspend() is a stub that returns 0. u-boot never suspends
> the controller, so there is nothing to do.
>
> Linux calls usb_phy_set_charger_current() from usb_phy_set_power().
> u-boot has no charger framework, so the call is left as a comment. It
> marks where the call goes if someone adds one later.
>
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  include/linux/usb/phy.h | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index 14b2c7eb2e63..afda7870e21e 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -21,6 +21,13 @@ enum usb_phy_interface {
>  	USBPHY_INTERFACE_MODE_HSIC,
>  };
>  
> +/* associate a type with PHY */
> +enum usb_phy_type {
> +	USB_PHY_TYPE_UNDEFINED,
> +	USB_PHY_TYPE_USB2,
> +	USB_PHY_TYPE_USB3,
> +};
> +
>  #if CONFIG_IS_ENABLED(DM_USB)
>  /**
>   * usb_get_phy_mode - Get phy mode for given device_node
> @@ -37,4 +44,53 @@ static inline enum usb_phy_interface usb_get_phy_mode(ofnode node)
>  }
>  #endif
>  
> +struct usb_phy {
> +	struct device		*dev;
> +
> +	/* initialize/shutdown the phy */
> +	int     (*init)(struct usb_phy *x);
> +	void    (*shutdown)(struct usb_phy *x);
> +
> +	/* enable/disable VBUS */
> +	int     (*set_vbus)(struct usb_phy *x, int on);
> +
> +	/* effective for B devices, ignored for A-peripheral */
> +	int     (*set_power)(struct usb_phy *x,
> +			     unsigned int mA);
> +};
> +
> +static inline int
> +usb_phy_init(struct usb_phy *x)
> +{
> +	if (x && x->init)
> +		return x->init(x);
> +
> +	return 0;
> +}
> +
> +static inline void
> +usb_phy_shutdown(struct usb_phy *x)
> +{
> +	if (x && x->shutdown)
> +		x->shutdown(x);
> +}
> +
> +static inline int
> +usb_phy_set_power(struct usb_phy *x, unsigned int mA)
> +{
> +	if (!x)
> +		return 0;
> +
> +	/* TODO usb_phy_set_charger_current(x, mA); */
> +
> +	if (x->set_power)
> +		return x->set_power(x, mA);

nit: missing newline here

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> +	return 0;
> +}
> +
> +static inline int
> +usb_phy_set_suspend(struct usb_phy *x, int suspend)
> +{
> +	return 0;
> +}
>  #endif /* __LINUX_USB_PHY_H */
> -- 
> 2.53.0
