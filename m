Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99D606D80F
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a8kdCpXi;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=f/crnFg+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EB73606BD;
	Tue,  3 Nov 2026 22:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rezmybnp-vu9; Tue,  3 Nov 2026 22:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FDA560698
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793743412;
	b=SbP0BzfFzPgOQxj6TK5d2l+ahGbS7K6AGEkfa6S+Pnwr7z4V0GPWU+Wc8zgejGyutSBj
	 vwGH1Cd4gMCfQj4CCUkdMWNOddloeNNFNHOG/2O5gWQ+H521Q+tiezFPUvcis/VmOM0Sq
	 gUTGTVXqc4n6lH4rcXQhF7Cth6zpr1GoryxR5BzDWoyM8A8uQfCLQnhUJ+KrEFjv54KeQ
	 ca6QLQlT890utOCAg0uwIBAoQ1MJTV6/xeCyU3oY6TNfSeknQxLweoHcuNnemlRg50lPp
	 LxNC8RxPslKNEUjAeVBarAvPPCoLXz5GEHGHH2WXqtQOsEb8i8HTvsfu/LsCSRq/JPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793743412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BiOrNt3v+3ctlP0eb9rw+QTkpdVTyqaykQIz0DopQ50=;
	b=NNWr9yAUbiKzcIrVulvxRmAjmtlqxL/qHoScKVffcOYaSZi29xX5eKU3dlOtLLFHkX09
	 gUXFSPA4/xJLhm893QvwkYYmFNupypBid8X44w7xKG0caPykEdSvDW0eU1B1Cs8OLW5OM
	 HVB2qwIhLYvooyx6syyeC+tVMNClfrxDMqyLv0Marz36OPirsfSb5kzndFB1CauP1QWmj
	 xpvqq/mGfOqh6BQMCWQNDvQPHugxZkzmqiBNCTyaWvlseCtsqr14/3qJ9gPHajhRj+Ggg
	 r05INrIsAfbbdSI+azrmtCjZYYKNkFuixHYdVA/IoXCHzrMZNPdg3PGldJxVHQoHmUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793743412;
	bh=BiOrNt3v+3ctlP0eb9rw+QTkpdVTyqaykQIz0DopQ50=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a8kdCpXi7Q5HNmiQQmZWElpnEDiLdD+9kcQpb1BBlC5pZY8nNj6FsyjIjEJUD/6xR
	 1HIwML6jXRWlqB3YsAbulABgPSlouFPaa1ElZdF7KTcR0B6sNBznivqf9yrAqjwqDA
	 jYZxK7qs7I3H4r1uQj4++WCfmLBvtBzHuJ7CnUgGIZMIXMkRpWwq/nAAH91C1DbXGb
	 RI8BERNiDJm4NPlHmjWduBrtfBjeIu3Pak/IlYLv8OMowwXoePAiuTaD8bcLXJQydI
	 LiBiIJiuz+FYUc0mCeSZcqTxVAT516vZ8LNQC9ywAeqjMCXFKa1kD1CRmYI35CyWwp
	 2gF/f4iiq9Htg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FDA560698;
	Tue,  3 Nov 2026 22:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A486437B
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A2E24054F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OFd1850ukc4 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 22:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9925B40343
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793743410;
 b=nExC7wDmv+5QsMiMS9BJDmxR6EL0JewtsNNmVf6WUKFnQbeMWvsSGPPyqyfFRouVcr2W
 7uPHJW/95IdlyR7yFDp367hjsVl9qbHkBnWaf+02jr8kQtpWxp167r5b92B5rVzz1Ofwg
 2IJzsDjK5vCY+OF9h2wH4cIeYNu8kDkw/nW4K+LeHbSWDi91hQ7e7Kup8UdSAUo7Lbv2Z
 evIVaibkc/+D43KSsaBlLfM+I43GT0UtcmrTVdu/ESANK2nMREeCzsbJRLsl3WcWqPEnw
 2pHLfUS1Oq89aOYD1ZZTXpewOJ8RX8wXv8+A6JL5c5xUiLet+zI4/Tjs+cSoOCtEYOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793743410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=BiOrNt3v+3ctlP0eb9rw+QTkpdVTyqaykQIz0DopQ50=;
 b=XF0YwEGVUqXX7R3STyCuqOWbgEmvRkqtSJmL9YZTTyNpN3wJlbKodxON7ldjA8093n1a
 rH+rTtYBgM0P3KnSa+TH6WG8JKe81AvBx9TXU77QQMlRsYRXpn7nLkpzLJdheqL96q6cP
 WeQCns8HCaRkNEj+DsVIsH3Ft9bnX4AZ2UptT2mUPMB6AijN1HIYajsWoDWqGC9cQpjA0
 CsBtqoZmASA0Ha09O1jvJ2Ruf5uptehjqTHUe5US+5t3CpL2axj7lVSA31iLV3yEK7jUZ
 baAHi7sFUHv5v4sc0Tb+2WBHZhvInzJtKslibs34nF0aGgEzCU4oD6WEdnVCHE/4SzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="f/crnFg+"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=f/crnFg+
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9925B40343
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:03:29 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so256625e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 14:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793743407; x=1794348207;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BiOrNt3v+3ctlP0eb9rw+QTkpdVTyqaykQIz0DopQ50=;
 b=f/crnFg+k6mORxY/vSliMyUrm7KS6C8JVtA0CobnjcA+8HkmYHNyj8bn8dwLeDia+m
 XTrNXGJ4n90SaZ6XF51vPOqAL9MnAq8zC4IG6hM93+eBX8cdYHealDOUBRC66qqKYROz
 OX0nk8It4KXiSJXizPkkDMeh7Ri1/zsv4SOmi1lwxMAZAoRDcMbMe/x54gIaRZFaaszB
 O7mEPOTm1BUzhYeeB3fJ1S1n7174wJ2S1wQET9+mcWH81sImFXb0mZiKiEFZAXK44C67
 zUPa+cShKsFLFQ2q4WJvq2VscDNQf6OKamCmkEUHKmA9cXFKPrEDOo6d48UB9QvpwZTY
 tFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793743407; x=1794348207;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BiOrNt3v+3ctlP0eb9rw+QTkpdVTyqaykQIz0DopQ50=;
 b=xEC0oaSm+SK5dLtmRD8tjJIS5pxo97KsJD90NKc7GAp0MfMLriBpmphgyts0QclUf4
 JVUWx/jrtCZ653gR+Zs1iYZwUT3mWEswFAIw/XBF5dJfePhbeScObhTbSXbicJxxmSE/
 tSo4yCBybFFvvyNXTPn7/XiQ85eXUrPu9tViXkrFSYW9OOR+ik8HvVgrPvV2ynpVxXeK
 s2iwlxaGwT2K75mvAwgjW1Nn9+K4KA4hayP+4F5UvESAuoEy1LZNLJW1KygttGbloPMj
 VeFUNep8RWqqIdQ/Bm7eEdjahZGdR7Lj/fZ/JLV7iRhM2Wxng71yAPZR3KMd/VdbgFjT
 3oIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykou5xYghoFoYxUbyHHJ0e1951WyNiCdSWRDEZvrbFKp5f7fXHF7hU/wSlaExXKWSWQtiBpts=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z94W4G3ap7pGUvSKiBedlnAMqqVT59uPLmGpWPDRKYA19DTSr7g
 52xG0Y1fWFK0txZzCTDpOqwEinyNJIvs1hJx11L1RS+VPCExTk70Rzmod9rJY9DHRl8=
X-Gm-Gg: AYBFou3guHZrrdqe2TGDvDtC3Cb7HiCqJc/PIjaNVwmRdmxlRdsd/A2vQ9cKJxP5uDq
 9+6J7H/Nw8EJgnwrayJNZirXIWUxmKbgkXklls6ctxeaZ1Vi1+1SIX0MOmQNZSUSBE5NVqgMuqu
 oavG4PzjInaesV73C/dHDJdBkVh/HPAFSNYXSp26t2RmOm+I7mIqh5X7FkWjX9dFUBiUvvv8xDa
 dINto0wtHHTxn8EmQ96TisMsJWBrDzxUJTsR1FyfknoAQm0fVhpwfK/ZzXipW3otW1dhw2ORADO
 +7ZHaCyg6ahJtWIntrpNe5EI8Ldj5ctahwV0BEqD3FUBvHeM2ilJjOsC0XKKZAkOmBYQ2WKFQEM
 gW2AhfE7n6nmklz/rVc/0C7UhwFwSoz4R6rLgFS9EBNrf+r4IobstmSPBIpOEBL778yn7WncIu5
 TLBMcIA1cYNjrTYmDtpgw8N2MWNmel4fKKTUnHShUS6cgI+n16QSrhUSQniyqkS5ppow1Tri/Ps
 ovCaFsYWHTZU89DZSojRDPFR8rxTv2FLftl7qWyR81sH3fVe5wsxYQhoYHWprJv57uoAIrXxd8T
 1KULKu8laFyHtE4r/eTOuBDCN0QS6Dqqd5exDjjp7ScXltKuwWY=
X-Received: by 2002:a05:600c:46d1:b0:4a3:59c9:a754 with SMTP id
 5b1f17b1804b1-4ac187a72f4mr327558215e9.22.1793743407260; 
 Tue, 03 Nov 2026 14:03:27 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b40ff10f88sm8956085e9.0.2026.11.03.14.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 14:03:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] cmd: fastboot: default the buffer address to
 $fastboot_addr_r
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io, 
 E Shattow <e@freeshell.de>
In-Reply-To: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
References: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 23:03:22 +0100
Message-Id: <179374340288.3904292.6355172712049573755.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793743406; l=264;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=SYpsM5elXT5nDrqTBkSB4XyqOJx+eiopOnYrmTFDP/I=;
 b=avPZ/fVHPcLkZdePK0jfoaUJ68yK+PWo6e6XZMCPPVHm7RkpISKhqE8RdZuiCgZsNQ9zbx7JZ
 xqwQ1c0uAKlCYnnIJZd8WK8PNI4+ayfu+XzKnCuPQARlVj1mVew8+W2
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 23:08:00 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> cmd: fastboot: default the buffer address to $fastboot_addr_r

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
