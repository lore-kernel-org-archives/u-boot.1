Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C430C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9CC680DCF;
	Thu, 27 Aug 2026 14:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIfuyj0UFjTL; Thu, 27 Aug 2026 14:12:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787839956;
	bh=E65WRO+1whBKhAAZPcUCCK9n5toA5Ka+e3vwu8QgyXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rdGKp7aKbP/xo8KYDIMNp1s/AGqCLbWWBkrt9y8WcO30KsJ5iuaT6kgt7eFmG5N8f
	 uQNpMs4ZeRkElJhQ/gE6Oh1gvLcgKmeLbsLPqsi8eA4whs9NHlX7bju48c9jzq1P0Y
	 UGz1jCuTBnMWPNMne+eRH9hjU/xwJdz0BcDij4o+4MyDSPnMNqvXd0Q5yxlDU/PjkB
	 OtuiDST020b6WFsz/eQa7J8+QG8dy0gZ+aRXsx1IwyKTNl+BaxSAM/ymAJZFXs+84Y
	 7nT2FWjptH/XPSufTblYwuhkxFLx7MRDSUeX5DW0AASsD1/F+BcoyUh/GNTZ/Y9iGA
	 lIlgHRF6+HgwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE29180DA4;
	Thu, 27 Aug 2026 14:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD5F139E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AECE940312
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PSfZvIPm8mNL for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:12:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LdHziJ4K
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88FA440304
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:12:33 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-90cc0ebbf4bso12369196d6.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787839952; x=1788444752;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E65WRO+1whBKhAAZPcUCCK9n5toA5Ka+e3vwu8QgyXo=;
 b=LdHziJ4KDgGr0d5Li0Y+uvJ3RPZLK/bg4LHLkwz/kGsjT2HeRojCv6L+YBanwelk8r
 MvGDzLCx7xgQBY0pl/4nC//XnH5pZd7t/9C2u6bpAFm/Sp1AMNB8YtgtH6NPJOPbxO6v
 cfiyV0OBq/AngQiQiWNMsw4FYRsDff8DM5jRBbchH6wXhYoLHUDsbFL1EFyFMh7eOpyf
 ka0SrPTHgFjo2ATzICofNP7rKIxwhW4qQmFAKlEwx3ikYoKqg2sg64/j2vHIptyRoc8Y
 h8vIW6eKXWuQ/TuLakEGj96xnMeR4mjJxslW68Zl4rs6RknoEnUyaTHqE2C2A0OJhadj
 Hrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787839952; x=1788444752;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E65WRO+1whBKhAAZPcUCCK9n5toA5Ka+e3vwu8QgyXo=;
 b=h7K9wgzomSKPC09BNWylACR+v64Xj8LJMRYicABdNmSIdVJwhN+C4w527334aBsx8k
 TItQ60/YRLqkQDvORGyo9XZnC/pz3TD2cwCQ2evapJTl+JYuGChhbTxoy7AUvid+IXB8
 /4LTaO/SKeV1tVZTGmM7meWYI30z9Wj8eKvW+AUzHdnO65LDQEq4u9VPsod3G5gxEXzc
 K31YJsfenW9l+eI0NwzKo1o87iAPZA3BqxuLXZl/7ywa9RD/XFMYXyJl03fIvX52xGo5
 TGeOFaRlwqfscRlOJY3/9r9DldHzoXQKuE40AWpGGeU8j1i6r6agcPzuNxKPn9EaORwv
 D//g==
X-Gm-Message-State: AFuF++nwuy6Ch8r6/Z5B+G6xqUxw/kMrxhMsB9kRR6faCru6f5Y3YDiW
 M7u6VtsbApbWFSe4SGPmDm5yiHu5zDzKvO0TXE+swpyaZr0PEG6FB5w1Ed0EcFTYDBg=
X-Gm-Gg: AR+sD11bk5WCMcIkF6ju0WtfSDZH/gFimwUt2js0046KmITBrgW7dpdgZiPCy/JQQ6/
 mZUPox2uRIHMNPcPcLH5Y2M0YWXG8R9AYb23p0pU7tjoF7O6YWmogQ23GS2I/H8vlPfmUe2XLvo
 SA5ndAmnx38D/qbDcN9eq6tC5NHaYuN9Ydb+HhhiD+xpL/lMxG9k3t1z9vVejgeZyk3VximhI72
 iUhThVT1iZ+M42yL+6IDYX7/Q2eCGW73PEplPdIbikZn/ZHS78aDHDCYoRo4JOj9MBGgi007lq4
 Obq8GDg4m9OsHalTa2kWxeO8BDQsTvi1LJmdwramK/MMl4C3N0psCrW9tbeKXqmVS+A4w0IPBXT
 AV/ShiJsh9ZetO8LmEFE5xlDEuYN2fHjcHKQpQXht83x2VApfBiQ2X12Xjj8+KxjjtPpFP4CW0H
 s70a6v8imsfjz2QJ/Ii4Q731le5doJxD3EJ/2AxTTKFUVy2lWv0UWLNOTXfQ8LP0s2aykmJNyg/
 2+RtL61mF69nUQbLV5cc0ZxDap1pKREK5DdoWVBGOzSBuLEFu0aUA==
X-Received: by 2002:a05:6214:2a46:b0:90c:d5f2:2cb7 with SMTP id
 6a1803df08f44-90cd5f22dfamr63278146d6.20.1787839951533; 
 Thu, 27 Aug 2026 07:12:31 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd700bfefsm17936736d6.5.2026.08.27.07.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:12:30 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:12:29 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2] mmc: zynq_sdhci: support Renesas RZ/N1
Message-ID: <apBFzRluireFK8tl@maple.netwinder.org>
References: <20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org>
 <4e3a48d8-d971-402f-9542-820f254abc77@mailbox.org>
 <ao3xXc7dNbFmKEha@maple.netwinder.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ao3xXc7dNbFmKEha@maple.netwinder.org>
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

On Tue, Aug 25, 2026 at 03:47:41PM -0400, Ralph Siemsen wrote:
>On Sat, Aug 15, 2026 at 12:21:11AM +0200, Marek Vasut wrote:
>>On 8/14/26 8:30 PM, Ralph Siemsen wrote:
>>> 		return ret;
>>> 	}
>>>-	clock = clk_get_rate(&clk);
>>>+	clock = clk_get_rate(&clks.clks[0]);
>>
>>Can the clock ever be non-first clock , i.e. do you need to handle 
>>clock-names DT property somehow ?
>
>It's not clear to me if the DT binding specifies the order. It says 
>there must be either 2 or 3 clocks, as well as clock-names properties.

I had another look at the clock ordering. According to [1]
  "Order in lists is significant, order in dicts is not."

The binding [2] uses a list for the clock names:

   clock-names:
     minItems: 2
     items:
       - const: clk_xin
       - const: clk_ahb
       - const: gate

And as we can see, the reference clock ("clk_xin") is listed first.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/example-schema.yaml#n47

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml#n116

As a further check, I reversed the order of the clocks, and then ran 
"make dtbs_check" to verify against DT schema. It complains:

arch/arm/dts/r9a06g032-rzn1-snarc.dtb: mmc@40100000 (renesas,r9a06g032-sdhci): clock-names:0: 'clk_xin' was expected
	from schema $id: http://devicetree.org/schemas/mmc/arasan,sdhci.yaml
arch/arm/dts/r9a06g032-rzn1-snarc.dtb: mmc@40100000 (renesas,r9a06g032-sdhci): clock-names:1: 'clk_ahb' was expected
	from schema $id: http://devicetree.org/schemas/mmc/arasan,sdhci.yaml

No complaint when the clocks are in the correct order.

>We could try using the name ("clk_xin") and if that fails, fall back on 
>using the first clock.

So I think we don't need this extra complexity after all. It should be 
fine to rely on the first clock being the correct one.

Ralph
