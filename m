Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74470F8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30C58407E;
	Thu, 16 Apr 2026 11:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G8RoupDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5342841D5; Thu, 16 Apr 2026 11:06:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B423483FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fxBvM0bMCz9tk9;
 Thu, 16 Apr 2026 11:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776330367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFz6mP6rjrGYlhQTvsAZLY2CFLYZNMdMwya+2SgeqnM=;
 b=G8RoupDh8AxTDA4cRLpx0WkDB+aywSCYEdVzxBExD7u5pYYl6/iGchDQcOldK7w1sbIETd
 xrsbFkDmDz8ouHnv0LlzD8EA1RBg3ODW8FLiW+rkm8iEqbsSnRB06No7VHkEMDkOeUkLxs
 8L+Umdi+0InIfcAfLCaWReBgTN2VoyHZFb5krb65VAgwmUspTkUiSuVMRJ/TtFzJ2ea7Oz
 j57qP8JvrV01SHT1iuVC2R3OEPVLSHIa9KcuG0Sc2kAtf81opCaHbnKlXWmKR9AI0hGX2T
 7T68AHRlQ+6igRJCTgf46VYwsr0Jkh+5mgZDH84s5001p9IGnDKFH+ujVeF90g==
Message-ID: <6f873006-9b2e-406d-a561-da951a5d0d5d@mailbox.org>
Date: Thu, 16 Apr 2026 11:06:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: dwc3: core: fix memory leaks in event buffer
 cleanup
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 trini@konsulko.com, mkorpershoek@kernel.org, macromorgan@hotmail.com,
 casey.connolly@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, u-boot@lists.denx.de
References: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4gfnmgmqx4itnronph3f9w73fx9ajmdi
X-MBO-RS-ID: e47a85424249cf28fe6
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

On 4/16/26 7:55 AM, Gurumoorthy Santhakumar wrote:
> In dwc3_free_one_event_buffer(), only the DMA buffer (evt->buf) was
> being freed via dma_free_coherent(), but the evt structure itself was
> never explicitly freed, causing a memory leak.
> 
> In dwc3_free_event_buffers(), the ev_buffs pointer array allocated
> with memalign() was never freed after iterating and releasing all
> individual event buffers, causing another memory leak.
> 
> Fix both leaks by freeing the evt struct in
> dwc3_free_one_event_buffer() and freeing dwc->ev_buffs in
> dwc3_free_event_buffers() after all entries have been released.
> 
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thank you
