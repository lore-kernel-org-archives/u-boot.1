Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62976C88E53
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 03:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B11240561;
	Sun, 13 Sep 2026 03:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJx0unz7YQyd; Sun, 13 Sep 2026 03:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D63F7404F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789268680;
	b=pmCs5kn2W5J/l4i9emI7PFXF9mMVCgn0l+7OAEDPbGL9B2TXhD4s/DFg452GHG9KoMYl
	 9J91iC5QKIzGf1soG/1qWNZhzSAP28ccmshybKCSXwpbIydumjWMykC4mZbm+mAcim/hz
	 xV35Ukuh1PMIkcnOQndE0TL4+glzdUczyFyCVnLX6HL7meECFZD3/7wQybuwD+BDi48vF
	 LrTouvUnzBjS9k+DGQgKDotXxuGAgwrMu/d6GUmjgA5f8uOsSctn9YiAdq0U6eZXb+mPL
	 2JogIg48LCCDnU0EgJulb+37frDtpzbzCLWV2OPS9NlobKAzrm4kSLihADtFGUwoCCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789268680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VxP+jtMdPugsDMSju+UcguUFVn0aQTBA+FGHTNqxtsU=;
	b=UN0SxDAOHAQbh9878qPIZNm0SVzuvc5jYUJCxC1Gm41dFYosu47DZ5qGgQQf7NadpxwY
	 0frSdKN0GIoDo98fPTLcbhTk4zSSgg6dUzMGK7SOY5bxGCP0GOus6997nb9Ya92+7JTmH
	 stySyG0zMbPpn1m1Q9jwNOEgAaYfQU7YDXJ62l9/vRL7FULrn3LYtrRZanrelR6mTNt0z
	 sgEBVn3jEJeMvZb7Y+CHWSnlL+wgZMHOHoqF1tL7mwdvAuOhAFUW5We9uQVzkLosnvO84
	 oXbTpo6CekR0t66+p7b7PE2kArzTpKIl6Zdds9QH/LHmqKkPUOYDy49o9KMOQ0PXl6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789268680;
	bh=VxP+jtMdPugsDMSju+UcguUFVn0aQTBA+FGHTNqxtsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kkRRzcXQNVK7aMiUq/Q+KHqfF1w4LZQNIhRjv4VcjzCI+gfIAZh8b8Za3i2enA+wP
	 dNGmLbKvHBYGyTyXEh6ikaDQGUH/ib4PHxmY9KeKF32FjS/OfyDSjLjrGmFv042AOi
	 fc8DEeDZ3XYjko1vr7FNX8eX3pEKLJdLD8BG7zeusTfMtxSmtFWnmmdn5GAjc6PHnt
	 NOKHMioR7NIhocDAS8IXzBlbZ4IIvU288YjN1gae4JMx7tgBPLulwV1xJk6FA17hAA
	 F2Ji5hZ0r5hF158ahSsDVC3HNf8NVPVuWnlnhcjlaN1jLQnRPXjY17KLYAg+53r5Lb
	 bm/xVAm+tmrdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D63F7404F6;
	Sun, 13 Sep 2026 03:04:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C575C7AB
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 925D0400AF
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKrBaRd10x4S for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 03:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9566B4009C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789268673;
 b=aq1ntK/swWyptyI+orrX9cIjMoIooJrRF9YBaDG8/876YKkSCC9I6AF9gf6wSwO1LnOd
 bvu0QA98LE4w6nTiPlkokLR5eADBLqWAHD13Pi7zxEMjh7ofm4tRPXy8uXlODn2k7C+6s
 AyEq/62wiIkm29GrThIBpCDZC7K7OapfXm6uaM9qovCVkJXNJ+wgzXOLduwAAAybLxL4V
 32zzNXV0p7zi83t3cy4+I+LK6Np95AsdwClHCQ9X9StK5usJx2M3GP4aJGeth2P0moQ2K
 mZMPkcXb8woNebl1j/MwQsYhS7BxcSH3lX8sgjRbEFoe54RTxro6xtRIFFFXaJaqOzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789268673;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=VxP+jtMdPugsDMSju+UcguUFVn0aQTBA+FGHTNqxtsU=;
 b=M0zLokZW6LJzVUlN3APwI64jriaRpD7/eDFPDW949XQ/pwH0iMKvHXPfuEUcvTTdcFAr
 RhaGIKSKI0vlBLDiYr4W1z7qjhoP2DYBS9mLrU0/dEvgOAL4sA4Sgt+bSHk7Ng9CC8G2N
 qXCfhDUSV0lTmFEH7nDbuwZ31R9uBFUHpQ59dcNOdVoMwevmHLOYFRHfHRK54AwxhDPEL
 PYSUVxdbyfE7XFKwE7KaEpJON9iKDpdQNaYBivDfbnaot+PeDCzVEzpTdFhbwojVnP+KB
 WIeLpidLqYSZ19bFIa8i/11i9e8l0HgCcFiXfW1+LfiGmP91AFjP1KVcVGtiQWg8qQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cOqieaaf; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cOqieaaf
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9566B4009C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:33 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hjCmt1cx2zMkwc;
 Sun, 13 Sep 2026 05:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789268670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxP+jtMdPugsDMSju+UcguUFVn0aQTBA+FGHTNqxtsU=;
 b=cOqieaafqDj2jV85g6vBzxkvjOj6zTa1jw4U0Go9dQWdSubqeSQbCtOi8T050203grCl8S
 VtesOHvfr0Oo0tE0p/j5ulNxkvB1OARTgbmEfpE/WSo1MBsJkQLotT4b1CnM0UTgRhwUaj
 3YEH47y+0x4zreJs2kJe/jAFe8v0km9t9khSvi8z00qvntRfqWU+a/ZMX0AuLND1hcXMic
 EQNz6zFBv/eBkd7q95y2r2bD9zof38Bk28GkkKwtPGCMSwNr3TpIlyLn/mBizrSM7Sz1Hr
 XUu3BiXaPgz4XzcvXMtYDPQDLv1QysrcT6cDNCwwVzwYrnSTfuU2sIKPb0JqDA==
Message-ID: <b2bac675-136b-441d-9fd5-da0c025363ca@mailbox.org>
Date: Sat, 12 Sep 2026 17:26:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] lib: lmb: return -EFAULT for partial bank-boundary
 overlap
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>
References: <20260912-lmb-alloc-addr-efault-v2-1-0a796adfd99d@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260912-lmb-alloc-addr-efault-v2-1-0a796adfd99d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9c5eega3kqybhszpizskd8ebi75wgiss
X-MBO-RS-ID: a0e356d6198573f68c4
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

On 9/12/26 2:34 PM, Balaji Selvanathan wrote:
> _lmb_alloc_addr() currently returns -EINVAL when a reservation overlaps
> an available memory bank but extends beyond the bank boundary. It
> returns -EFAULT when the reservation does not overlap any available
> memory bank.

It returns EFAULT when the reservation is attempted over memory that is 
not present, is that what the second sentence means ?

>  From LMB's perspective, neither request can be satisfied because the
> requested reservation is not fully contained within an available region.
> Callers therefore cannot make practical use of the distinction.

Have you confirmed this for every possible caller ?

> boot_fdt_handle_region() treats -EFAULT as a non-fatal condition and
> silently skips the reservation, while -EINVAL causes a boot-time error
> message to be printed. For bank-boundary overlap cases this message is
> misleading because no internal LMB error has occurred; the reservation
> simply does not fit within available memory.

If reservation does not fit into available memory, that sounds like a 
fatal error.

The commit message STILL does not explain why do you think the overlap 
is not a serious error, and why it could be ignored. I already asked 
this in V1, and got pointed to this V2 which only contains more blurb in 
the commit message, but no actual answer to my question.
