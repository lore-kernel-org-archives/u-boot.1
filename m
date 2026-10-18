Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA487CCF2D4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 23:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6360580F7A;
	Sun, 18 Oct 2026 23:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zW8c15qiMjxT; Sun, 18 Oct 2026 23:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F35B80F7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792364916;
	b=ldwQnr/8nZMWz6YFLVjppJlQUSoj6UBtpzdZCvtLct9wWDRuXiAaoCaMWvcAoc1iY83h
	 a7g1Rzm92VAdasboSgigH5ZLnQOOj2wXtX3xOMF1Wvpq+Zbu2M2H90E9OZ24PccIZkC9r
	 v6U5XTfrhCmPLqzAJggBG1QW2KDkzq4Nb/vFIWrJ5RsiND7FNqifcVlbiSRicRmQPr8Ca
	 jgm9xlgFBpG0YaBxxPnA9DpJwd5bhAIlHbaUaxgONMnt6hgwsXr1q61MnQEbbnqXMNq72
	 AzkUKh0dTCwdCzavnkg6L7m4yomevDbTo/6QFl6YiQfzJ4ExdvT7nV+VCUc3h47xBRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792364916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OeuZghsD4YbzgOFTTjTgBN/HNCVRDianiNEQokFDx3w=;
	b=AqmY7z9Cx6cddngYg6Sl8UPWJOlbKlVf+m2F8rSk8X4GVC70XotV+lJSPAv6PVDxOytA
	 U6aPUkef+yDabQY+pZW8ULJY+d4jZHQOaknPL1/fIoJvxHYncMGtPyYcwLHXFit8iEElh
	 i87j8laf8gvr72W2DfdwIJs+v4DhvEM8B3Rs/VaR5z2FaEUQFM1W+nIfcu//RKO7JrMm4
	 R0ZXCea2zy1CGcjKmbrXDfamHbu83ocQhNaN7V1RXycPmLOvDrr1Ij0wNoL0VOOZBUIN1
	 FOdbdGw1fqVPav18KJa0Vl/O4sLLg+ffDiFyMFZw79d2AvrD793qjFbAIMG9n5dHtQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792364916;
	bh=OeuZghsD4YbzgOFTTjTgBN/HNCVRDianiNEQokFDx3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xFvS0fldUbLn78mxnBkfFdotIY7+9ANz5jQ0OI945pchirtQOqIk509oK0u9xkf3Z
	 8Ja47A1c8MaiyqxhFZLNM7I2HFKIg2Jw2Lo7jQ4D/XvEae3DMum41Ii+vQxcSedC1P
	 Fctjq1qhSy7uhM6+Yyzey+FTZ1fIe+aXjh0FOjN3kxUTd7OCZQCRoJj8PTolP+mOkB
	 MC89RobFxLjHeQs4BpAXTDRhnKbQo6sKmJyLl7tkShB22Eb5SzIJSrUKb9VVXs8I4R
	 JNsjA7ds9WEpdAvaGjcMtVLD21jSKH5RPzznS5SH2Gt3pYELKrBnewIQxpG/7NjBDz
	 thZZKiHy5hHuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F35B80F7B;
	Sun, 18 Oct 2026 23:08:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D5B3255
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E167400AE
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XGJ5f52GZP4A for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 23:08:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2831640064
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792364912;
 b=RBxzLEIKt5Ez8NZlEENeDjG0GPr6D67k/eo17KRpfmuXPtJuK0zx4k7f23x53tqXy0At
 ZUNYiG5O7cfR5RBe3oGxbpRbtC4CglbB2NQcm2zgndlcZ7WvqcfcWC47NtKbbXPHG3qN0
 eAnQUfVZu5N51AHd/ULzoSBZEopw4UzHoh2wTnvZDX+dzC/d1XnA7j2qbyQSODvar35hj
 u8GmpccQuFiSHOKGsXQnCLPsIbtPt2oA2D1hUYecksJdp8LelgnhT4HFOnlhZkDDWUiPI
 SmpbSpWdnKmctRDLmpYnEwdEbnrf83njhXoFxExNJss1Eyye5ETJlyF101W6jw3IzaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792364912;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=OeuZghsD4YbzgOFTTjTgBN/HNCVRDianiNEQokFDx3w=;
 b=PoVB+NLaeLpbGeKn9PX3Sagl7Zy2qb2TO3gI6o0XGSYqN5fxdhyZ+4D2Bw0enkwaQ9rU
 k8eqDjB5ckNPHF3jl2MMnD/rfcuD+bzspoQVX4x3KCaONZswu6j6DdnlUC7AeOPy1kWkE
 fiSpdON5S1LJ95+yWVtpCeVIpxAnC8CR9COtnm3cpL3fJX+f9qzOQcYBEcZYyi7B2Np3p
 yoPXYIJFRAVvr++6oak0ShnpUkCrcZDOTKab2NMbPfjztQy610L/AhXKPVN4ZPx1QwzyR
 qwZCNPoXZVRb2Jje+eLOokWfQJ5vq7Cb2BNkvr1dZfnX4WCI2FHB4VQNfr6D8sXit6g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vzGdfUyw; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vzGdfUyw
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2831640064
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:08:29 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j7Dqs6s5qzKp6Q;
 Mon, 19 Oct 2026 01:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792364906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OeuZghsD4YbzgOFTTjTgBN/HNCVRDianiNEQokFDx3w=;
 b=vzGdfUywXOAcJUtXukfyFNqR4kp8s8q269qdUYwNT8Z47mGIsMz7RVnT0vBqs5gotRytnz
 AIoa61rWlu1GH+xHGAsd/detlF8kZJ8r/61QQm1J9hB/KPMIXCE2pU9d5qaMwg7Ua97RPF
 wKJqIkue7iQoHaWN0QZdiMyUIP1zpB1qAW0yhEj8uQtawnAL+s5GVTOYZbIlNwUK3mSp1h
 WF/P/xBBWPyTJpG5eXNt3AvaAE/KWEjM5JMoXWgOVu385K1p/pCIpd9LeCscBttJwsP3vb
 2J4V3JfPkGaj3h3SxlctnfdfisoEvO4hBZyrjq0Jdlr59GBIAzOFP2es6pMIuA==
Message-ID: <8ab82798-f91d-4337-892f-3e54a8980010@mailbox.org>
Date: Sun, 18 Oct 2026 23:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] usb: ehci-vf: take the register bases from the
 device tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261018193620.2896624-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261018193620.2896624-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d26517cfe2427dbdaac
X-MBO-RS-META: n7f9fa6p7fi75rgkyk3msyi8qyhc3srh
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

On 10/18/26 9:36 PM, Mehmet Fide wrote:
> Hi Marek,
> 
> On 2026-10-16, Marek Vasut wrote:
>> Why did the portnr data type change here ?
>>
>> Can portnr be negative ?
> 
> ofnode_get_alias_seq() writes an int, the same contract as
> dev_read_alias_seq(), so the field takes its type. The value is the
> usbphy alias number, 0 or 1, never negative: when the lookup fails the
> function returns the error before the field is read. I will say so in
> the commit message of v7.
It seems portnr should be unsigned int in struct ehci_vf_priv_data {} ?
