Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9933606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tO61ljkd;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=QjFqNMyk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8916D408E4;
	Fri, 23 Oct 2026 14:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yv2jgrXOKTtL; Fri, 23 Oct 2026 14:23:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE19440928
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792765437;
	b=bewu4X1uwVY8La9RVKXsPmDt0VDt14FzbG5m4jNJx7Jo8PZGqguqQ4lInitZKHzXj6wP
	 boxWxeU1G2kLAfFDgPbCwe2CXIOpQfgrOyvBPvlFes1sQ/tcYBDgB5uLbUWu0FaUaQRr1
	 3f89YOl//ryzXmBog3cmI5Tm2l4r9WxTZ6/w7KsqqcqWHOr1bfOLkCtFLayzOTtjhKIE/
	 ueJy1gCl65cKC7yg5pWvW3LkQXXLgzHqzH2sbQG0w9Sbc6ZYZo+CbTlJeguqM2jU3cu0I
	 Yhs+04JS3PfhDERa2xPR+iEtb1t+Dajfn0Ltz1Xkgo2C93kaQk5j1AVh1L6xktXjiGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792765437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1JEdTkg7YBNJ6cVcJkGoKAnq+DDrblWYVt1928KvAnI=;
	b=j26bGUHxe2jV1svB2PFmVrRnEcg6wMUkqhabuR4LmEMxPObknJSJjUI/CcEgDJhV/9DV
	 tpMPmEPxz7H2tvMCUN0QWp0i8pQdl6lWsSEqUY87sWG7MWz9xnEBaz0zobcrt8p9ic4OW
	 8WJVIRSKZHMPlB/72A74OHK8ujGrIggljl98eAeHaRXW5HCyQy2m6WUDqLMnth/hZytks
	 PncsXoZnyhY859JO4zz9ZpI9rvWJEVFXJ+1ir3tFnuT593LpTAjLfJVniSrMtFcy8IJIT
	 6z5kLflJqXzpi6oAt0b8OFAgq/32HsXGkBksOYbHHBziySkAf0OjLap8sYm47H0+eRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792765436;
	bh=1JEdTkg7YBNJ6cVcJkGoKAnq+DDrblWYVt1928KvAnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tO61ljkdFhlebfSBogNwDjpyIDWvjFzFW7s6T2BMyLsBYHhsDDv91MxfEdcb0EX7s
	 aJRLT4+SvMaUYuOKz8XTkCg2lXTbY9Mg4CLiEB0JWEZ2CUpQTWWvyvG6fKhOdcV11P
	 MBX3oQHvC2GxZfi6vWxtJaLlaqFcTMmyubT5CimvNz6Y0mjTeveFatg6/Opm9cgxzK
	 KZ+ntUnkAV7BAIAkI36Vbee1r+hHhgfDo68fnWtr90rOCXiqXgBK+rtROofYv7OZjZ
	 kJKu9K5aPv5KtcSDV9BE5yENZ0nuQpuO/Yxgln0qaWU9Ih2Hx464iFYk5YpXp343re
	 RX7yYhoHVuuEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE19440928;
	Fri, 23 Oct 2026 14:23:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E82E12C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1060F401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 27aG4BIJONwB for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:23:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 49162400D0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792765434;
 b=dqKmn/FFPZh/FkIB3EufN07LbSWzb3bh4sHBVRokrGBEgyDfMH89sAvmKJCt3bpzIdo5
 WkoH4ZCvWtoCLbKq7VdF3HfIYLAVX6y7/Kudgpt76meng4QozRu0kqx0Bu3xl6DuKZevp
 xlP9oi7u+XrrWxKnM3t9qWEDT0P8JLQqAPjpHESl/dWzbWB9O0YjF21ZKBYUcN6UnLU+W
 yQqXoBJRCoah0hvCOJxpGydm1ZJKnL4eVGeM6VHo4+l/YlTmUCYAi1FrcPFBzx44yeKT6
 AeTX+IkG3RTsx6uCf3mhwOvWJj1iHXZa3f4AW4I9+lFWJsMXVcYSYTUA0D6UJa1GZaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792765434;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=1JEdTkg7YBNJ6cVcJkGoKAnq+DDrblWYVt1928KvAnI=;
 b=IMW9cZJldLSCzS3yqmbbn8dmkaj+aZ3isPVv/88ydISKmrW59jrR5UY5EhcWelN4QUpp
 FsFP9NgdTGM+gKE7vsNaOeoiDdekUnbpSaz4c0/42wxL28p2ohjrI12N7/3r0rj54CKVz
 EbbORIUlIZoW+TYGhsxXLGCYh3P3ET7SwiEgscHNas47ST3fvsEwSltOOQmcMp27CZkRD
 HdQRbwJ0IPwzmagzD2OerQ0rHNUnMliLDbntXxMV4m1fhK456Vu2xxuxSdB6Si+fIB6Qw
 zQJLUNWC0IdFFHHg5af8WFLKUxQ5tTg+hQGxFgYuv/pqZmnQdfiBKn1u2LsR3qPanEg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=QjFqNMyk; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=QjFqNMyk
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49162400D0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:23:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jB4yF274RzMlQJ;
 Fri, 23 Oct 2026 16:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792765429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JEdTkg7YBNJ6cVcJkGoKAnq+DDrblWYVt1928KvAnI=;
 b=QjFqNMykJgjOKTHQin4e1tV7MhPFjakUqKZ0czJv2hec6RC5OLKJYiD9KcC3kVw6OqSw5/
 GDpd0vESpyviaW/7jaMlo8qWEH5CgbrD82b5zyyB2ywoDVRDU4h32JnU7ZLIlKMFqfqW8p
 XK1gSnNGVl9hu/cSFqK9Lc+Y4PnGmhi0/GlPp3ido0qGl5YsFRpoEhIGO7eA/Fi6oPOdPU
 06ni1uGbr4yO/z7eu7cBVDyWFT/qHoZ96C5OD2uypS8cYJnGg2sAPyDfT1W6XNExMRckCE
 Qcx8r6e4Gvu8i0FHn+d+daPi7+rm6VgI77A00H8OEVd3mdeA3znGJg84J19MIA==
Message-ID: <a55838d3-09b6-49b0-8fe5-2f84b4b901ae@mailbox.org>
Date: Fri, 23 Oct 2026 15:49:31 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/9] usb: ehci-vf: sort the includes
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
 <20261023111559.4081795-9-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261023111559.4081795-9-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6b9sotun9zeea1uo43stsr9p149h766m
X-MBO-RS-ID: 0f4ec847211910d1ae4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 1:15 PM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> Put the includes in the order the coding style asks for: the top-level
> headers, then the ones in subdirectories, each in alphabetical order.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
