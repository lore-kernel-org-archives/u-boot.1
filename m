Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85DCA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 05:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9802160685;
	Fri,  9 Oct 2026 05:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NE9iYktg3CH9; Fri,  9 Oct 2026 05:45:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EBA0F6082C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791524716;
	b=QV0SOJex9iIeKj2mrKJY/t1VpY+jJy5CMqseW7YOvF1sDzJ9RrNcrMMNMZ9vsf4uuHpx
	 LVEDXl1N8nYCnG3wsCURnBbH7DP63q//DsDArfRZbjvzqeZcDRPkvexUhwKc4rDnri4n+
	 osnz+fdWuMktW1oLD8MvldMENEjKpniD+sSCzH2VpKx/qeglWIigZkt0ASA2OwDayISN5
	 689XYwlCAfEXCIYiQAX7lcMwGmnEGcK/7aTNUKQeOqK2l2nhnYIQWHGIqfVqVUDjM6TDS
	 kki7fMJI8Gt1crI+nrtcZQczRvRm3YdJXNsHzWcn/5VkitoOwkauJEf30aqeb8cg7HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791524716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g7YZ6CcXmfxW/0TCWyg0PfYHLnObZEC0dBz/6eDkmzo=;
	b=ZRop2HUhBOCZ0+CBwOXzqJqo/fx5fc7B2LEgWgEXG3mSLLwz0loxnMGRz7oaFDcbGJml
	 MzxYYLciUudBZ/U4hSNe52MhER17qYnYVppXvzxrT+1D0N+HZy/T+VP3OOeDFz42y6p36
	 3k2j19QsWHeFqLfsm0YGVIBe9fQXCvrDwlhK02i92gDOYUueX3bihcT/NdHVQBujFkxEX
	 cJ3cfcmjPgMqg7OF28cyq2y+l9MeUp86e3LJBV0SVwVrsCDo61khNogM1rEnf5pfcQT7y
	 1Mw7ILQlkt3NelXjqnlBaUAsz1tdHX+72Dh21MdbqseRWgEY1U7JyBr1sO0VdDrIIpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791524716;
	bh=g7YZ6CcXmfxW/0TCWyg0PfYHLnObZEC0dBz/6eDkmzo=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WFMwA/HCY/kIcc1N0OOPVFtzSFj3DgJQkXOqN3Dvj+t0JxEWSIT76e8LKKKi5SoSk
	 HwNhcmfJDmf7aX/U0bPWZQHF1Izyp1i004JTr9xjOmT5EiamcITwC+7ai5IdFeTb7v
	 kw0zkqdQXP3HS0JRSJG5+vbcPNMEcnQih8YdCHXNq0hlt+v8b+tT+k6WlvVUxx/E0e
	 XxdoNmtPY5gRa8ZV0BqN+cHdi0sTv6tl5H4ODn/bQHutbS4HiedK7/zQZYrAaTJ1Yh
	 XwlztCUudmlU3J2jGQbZiwjpQCgQ4oDbmA7wm8exzV8x5hjrU/nWnxlJHG8spQP8Ih
	 rSAak4vHfYNDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBA0F6082C;
	Fri,  9 Oct 2026 05:45:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05CCC228
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBF0540061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:45:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wGqmYmohxZEC for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 05:45:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F02114009C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791524713;
 b=Gx5bHcWpMrs5mIZjLpVIRR/H0IYgSAO71t4pD7paShKMVowcgy1ZttWsj9Ee0hMJNHB7
 662oGH8a8UaVjJHVka3CcN4AQ6tpGhGFpMuotj5lCTLQKSIQEDp+WbgxitKohODOhyDIx
 GJf3Z1vFWsErVJ15CVds+HEIfglBdl/DXp2CQLIScgNHBVgyR145fOBwzgBW5jELuY81N
 zL55WBz9kVaeMTwdjeLpQVGap0BDPKTlTC50Wc77CRHoxzWH0lrnPNpM7C4cL7JNMGjsx
 wyBp+EU5H9B+PZLSnzTz9bXAUa+wKK4T2Irvj8Nvh/a3YNuf6A/uHidDv9fDLLst8+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791524713;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=g7YZ6CcXmfxW/0TCWyg0PfYHLnObZEC0dBz/6eDkmzo=;
 b=kAdFW3TWPJ/eA60N5EXupDFMW2e1LPWWgou1of66nPX8dtdixV56VovsmGHnouWko2mq
 8qRAP/xOiuKeRhUgey0YbcLPDdzegUhrJqEQoEDKmW7FbiedwaK0mdhG/jhHW//5x5NcT
 9wqaxdvCthoHSU+8/5ArEwNYWWjq1zrfIOmrnJo6t1Y9vA1cadqQLEdi/dGiFYTXQfnNx
 FUEkMih0I0rGpS7vb/JdfI+xrXjBnSG3ZclaUPOeNynRP6ZZt5JPdTdrH0rzu+tJxECrS
 yKaSVl/CVQ1xbNHmA710gMTogqB3YRY857vku1aCRNUxcskNPS3HqKcVY3lSE2f4SKQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=V+FYAylM; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=V+FYAylM
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F02114009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:45:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 633AE105B1A; Fri, 09 Oct 2026 07:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791524706;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=g7YZ6CcXmfxW/0TCWyg0PfYHLnObZEC0dBz/6eDkmzo=;
 b=V+FYAylMfL6lZieIfBoh6bQ+wHJjMzzkjK/HchDtpEqslnHJpAG/nCczisDKOwtvKZ9mk1
 007qYHhWXvb5pUC7vz3nVJafJj9n76rp/xi6TJQ1MkX2IXOlo19f7MSRRxrO79TmSStWrB
 8nP0pfAHExlJRd2e85toC8ep4ZBvMsNRASmTEpTMvErTERfqiUhp0J1/eA0wn9xX+RMvCI
 +qGfEFD1LT9RUY6F8SZ72tDNPi9XSYIHOMiB2AKd5B9tp/PtC208CUF81VKYjw9M+0ARR7
 whpSos1D8c5H5MP9oRRIn0bH1e8TCeoxcW9u0kl/fvbJoEyO8wmEdPfHX9MP1A==
Message-ID: <863566db-5ef9-6ead-c5e6-f5f223b7b2e1@nabladev.com>
Date: Fri, 9 Oct 2026 07:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.u-boot-project.org
References: <20260918025347.1839402-1-JJLIU0@nuvoton.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: npcm: Add segment feature for bus select
In-Reply-To: <20260918025347.1839402-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Jim,

dropped u-boot@lists.denx.de from cc

On 18.09.26 04:53, Jim Liu wrote:
> Add segment setting for bus select
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>   drivers/i2c/npcm_i2c.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

(There are some checkpatch warnings, I fix them when applying
to u-boot-i2c).

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
