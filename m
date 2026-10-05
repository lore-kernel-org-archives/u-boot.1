Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8454CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0942A4068C;
	Mon,  5 Oct 2026 11:20:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wG24dLLhhg4; Mon,  5 Oct 2026 11:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 957AC4066C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791199232;
	b=Tad2I+l3ybRAPlFFGxoMimyDJsnq5CtqODmeEbWwZvQ8JDLmYbkXB9MuAYGHy9SxjIrn
	 KI0dNt+PYfqy8wh+LwlYYBiHQGcgCuSYzjRs/pZlNrX1x1BKSR9aC9XarPpyl5XxrUJTG
	 QackrprPiXccl7S8sn0XBhsFigau+SHFe0h4h/8vWwiaaqqSlCqB8Ah0250g7Rteo0kvM
	 P2JW9NpcfwanziHgnYIjOqavOwmaW6KpXEkSP7ush+GltgH1X1Q+zeRRHCEnlTP0bc9Eo
	 aL3WAmc29xoJGM/NIyvNpG7xuYuj6OYeJUYZGuiqqIhh6sM9ZpIJ3l1WwV9NSugT/3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791199232;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sKZUCyBELoveX3Rqd7DU+xw8w268mIQHxxdIZVINPzo=;
	b=Yhc3fGBfqXR/V2BMIAw/boOBQkY9p7fI5dbB3uwuALwoKaP50iQeoARKTb33LN+48xZP
	 y3KjKv1VOIwm4D2T6jjQ7gbLFios9S5q8NAUrq6E9loK5zf7zpsfASYqeQ4cwT9sSuOaA
	 nwqlL9QJDNFecu31AlA57KYw7TnvLKIiQY/qc9WbRgeAtGRnxeFj8zNjc1HSLVVgcf9qc
	 2QYAp679dwz7R4yoS7JAnG0GlWCRwtZ+AxhfuKozKxCU45WT6PT+wYDA8rUvk6HbEVjzg
	 Jrg0R3EDC7eHM1QuQ8H7MrD8R7Orf3nIQaAUqu1aNTmGn1q6v+UiGOxnBFT+1kJ9tKQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jhoExQAn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791199232;
	bh=sKZUCyBELoveX3Rqd7DU+xw8w268mIQHxxdIZVINPzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n0XsBo7g/YXuoe2T7SJz3LlRFnFFfIEMQDUXh5l1or2nqvVzA890zX7K/4Lgp/ale
	 3YgCTHb027VbzH9RIoUjDVS+1iGowROErIGE/+LQ3DiM8NoD40ZOjH7EjQNP7xaSbW
	 CykTLy6bey/govh12Rm0L3xEHjr5wrXOH/Rs/slzkkdI+t94I0LffVolbkhIlGztaX
	 /SiNt2QhFvtf8GQiqT/xBESj0eUBoBq7jLbBXR6B3tRFOXb71apHdNFQ1Vhip7T86f
	 VPy9spqOMy24zOgE0SSutLtn39/KFYxrATTw+KOmCd9RtgA2odh2BPUN71qJzDHH5t
	 KLIagU48GElDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 957AC4066C;
	Mon,  5 Oct 2026 11:20:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 465422E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3594A4058B
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ELg7VtE_okV for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 63EA340589
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791198801;
 b=JRCe24L8BBc0GFyhScUygGXgInMezz5JzhJBm6zfwbbyqePJkumklMbMkBNej6gDq7pM
 PehRg9RGOoLghrw0Gv5/+tvkQFt9y2iDvYcRDTn6Ca1sebOMjCanECe7RPVMJxlR0hVgF
 7ZrdAbriueep8VQBtUqbbxaI62FIz7zI+rOzfBMAqyrkwFxVdk//FZ6oGN21Dhjp+c0Uh
 OrH96J5lUhTwPblU62s6cyGFzu9pbV80lI9ybocmYN1zwsPizLfY1/c+88dv09Bl40j5t
 eJRvtjkKZSCn3HLaM1bk3/F2px6/n3Fykg2937HboK75dfPLBVQRVpl6vQL3wLjVPAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198801;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=sKZUCyBELoveX3Rqd7DU+xw8w268mIQHxxdIZVINPzo=;
 b=cfx6dW5gFOqGKos3jKOLHnI2jWdpvVbozgg3Hd1M6FsEkehv5gUptHcUx73C7ErTmCFN
 ZKvskF0ZjVKu0jR8cPJbBjlkmkF2n4xdEb0dLxL29JCPFRpgZmRTG6SybVNJmZGaWM4Y7
 i7fHArz03OVPeLF9acIz36NnEXWQiWXar6YWE/CWiUSCZEJl1dYl0CNu47P1jpaTYNEHF
 I7fjkfeogSqHCicK9+l3ln91gJcfVVcIdkHAVmwx2rZYWRjZ5c4jQruLjneCPTivGQ/O3
 HGwUYlcxIufg86NQmxkrZDZ4xhlVo+EsWs6OYd7TDahjFmmSMcunVrfJOmACvCPjzNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jhoExQAn; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jhoExQAn
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63EA340589
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:20 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hyxZh28HyzMlQS;
 Mon, 05 Oct 2026 13:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791198796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKZUCyBELoveX3Rqd7DU+xw8w268mIQHxxdIZVINPzo=;
 b=jhoExQAn8QNIN6MfptxaMHR6V84hucjPdHGLRINB7p6mdLwU/4QBFbcpljaK6FyjvIwTVO
 QzxDf5Dn6U+x1O0wAtu2y56ZTSmIRo+5Rg4YlQWpLwWq36tw5UZFzWHz8Lud60yNhIOmdF
 RSG67IilSBQm3FUKDc8FKbTX3e+18D7HAGup4wRS53LJvSA72slVGimG9SqpyTqi+rkM/K
 2AVFQPyjb/nGJ3Jgmcs8eG/pGZspeJB03SflNliiw8NJoRQe2AElDdNyabMRbEsf76r+hK
 tkgTZ8hIIk/BlUwJuhbnihHjGsHQFFwa+3vzQW6PRF3cJ0Vubkt1g1xqPTw8cg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3 1/6] watchdog: wdt-uclass: rename str to svc_str in
 wdt_start()
Date: Mon,  5 Oct 2026 13:11:52 +0200
Message-ID: <20261005111314.719129-1-stefan.roese@mailbox.org>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-1-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <20260818-rinta-watchdog-gettime-v3-1-423f5caf526d@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 757993a4ed524a6659b
X-MBO-RS-META: m6gqpuxkugmxyumbjkgin3chuki73gdz
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

On 8/18/26 10:43, Juuso Rinta wrote:

> Rename the servicing string from str to svc_str in wdt_start(),
> replace memset with svc_str[0] = '\0', and use sizeof(svc_str)
> in snprintf.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
