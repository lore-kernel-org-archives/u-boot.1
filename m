Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24444606A31A
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EaHMWhiO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=k107EVv9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AFC860761;
	Mon, 19 Oct 2026 17:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fmb8UTgqiXA4; Mon, 19 Oct 2026 17:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3259360762
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792430751;
	b=qmOubDcy3XGhjQ8BjT13P0OcNrD8APT6yJ4nc0Ep77EeKGmK7j53tPkSGvMVYfNlmclg
	 rG6124F45A9ohEGUYVGdL7N0/e+aqylcqXbKW/NnUy1JRUva1zbqxRgsq+33kd7yHe1R+
	 IeM78kuMfg9LH/QEYsG3TustElSSQB+1/rQUfP1KlQoplRbi/YjABnpkgk4syxy9RogOL
	 x+A94n1KBPYx47KcHvkML+cnM7v/LgQ0uCY4ihq/XSfuO+RP9X+t6w9vv4ygs83DYqsGe
	 yybRP4ry6GiTtLskQhoEuOCVhVQIQ+scxNIHdXqhhVbRMloJ/WGcFZo1xhRYZKrRv8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792430751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s278JFLhezN8Gkm/FK18BymQx7J+8Zj8rnTYcg3SPnw=;
	b=FjLWubZ+BAgcS2IIYm2HRj4M8l23Z7batT1A92nnFHZbPaMJYAKk6tCLNR5Xc5y/lZAK
	 ngOE9Pd8b9eZ+WPrXW6UTyEn+RIPVIetLB7g/ckl12Vz3I5h4Ray+veKYfq1W6hikzDIj
	 w4f5gNnnwUGHd8uXVhqjukDjIMng6kK/vNh7ky6YZWvfneHV1LEp5T26KnzlI4h3bKa63
	 NNhIXpB4eHskpIjkMRjRUldYzADs2WrY5kFu2O5KnCkk8Zm8jR27IwhoC7vnf/M4zcTcz
	 vz+l9x1Iou5d/2fXzQcin8vbQM7moxSA8k4F/6CxA6R7JmqfV5wAPnYspnvegPjiwxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792430751;
	bh=s278JFLhezN8Gkm/FK18BymQx7J+8Zj8rnTYcg3SPnw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EaHMWhiOqEmhlYJbLjHEmpFxQkbhBCZLTNeXVEtnB6j7RfWtjgKPY9+PeR/GD914i
	 58BDH70oKuJka05Z5lV6TsLxTMVQdmOb22nSlJe4Ir/Z9X1IPIOmFvcBXUOuuAa0K9
	 OpLvIMg+SCMuLR/N8WAzj0UcseG2p+J8XuWx2U8pcZMzLRBK3nWYTZ93yMZxsjQS1i
	 zTLHVTo3MgEeeNKDKtMrIbF3m1YBfS013+1FWbN9rgYgI1fmKMnSSYSmmkKpp3UYOl
	 CyEnl6hAvAcdjj0KwKimZe5QgdI7thL2AVE2gkkhqJQ4Sm/Jz1jeX1QGF5i72yeTIc
	 p/yqjomIyiljQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3259360762;
	Mon, 19 Oct 2026 17:25:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5373923F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4557B40699
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_seKygiEhxT for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:25:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 77B444056C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792430743;
 b=ZMuefThGG6Fb2H+HbDK0pq7d6vPbl+3f25ypAWieUzp+ohCFC3shwIkp2m73LmVB5s+2
 vd+sYh2J68MygLC3goZOF6d+GfWm93BT6yYBzA12l8xigXVfexqmD/m+eT+ieYbOuX6Bi
 I7dnCmDy5NLAqoUindpEZnsb83CoMB7hxTTHt1WfWbJsX/YeHVQUty4r/ydoaECcfF1j3
 e4KKr9RiecVaEdFWg6f27W67b9XPwmJJL0s6Qt3I0xyKHFFjj3epikHtD6D2OBwusi2ae
 qvhhTHInJwtJ+M54QQxPhFjjRYmmb7rQGwHUIxlksLeTFkDklX9evJwHyVc3vsAZT3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792430743;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=s278JFLhezN8Gkm/FK18BymQx7J+8Zj8rnTYcg3SPnw=;
 b=bZGTND7JwulkwNcWWuFM/V4GGbjGUleTI4SrmXiG26atuN2gkf2j0SvZMT4klb8b9JbW
 VMQ9TDO+QNL9pa/vfaxyGyWmy9+hbO347GftyqJInaSdPphkLy/D3uXhYNRKXOdRMfpL3
 r/PHjINGE8Qzf0JPrvaO81aIZQ3k1OJGI7cELaqqwud5lptYn40e6oslqSBiFSgjv3zzf
 EmJ9rR6q5HwMEaIscJ0onTYYRVmjsXExDJFUSSibktfqoW29WGH+3++fl25Px3ZPzHXkK
 tluBXi08CXIe0q7rIIoGBQemqpGuCOSVTX+JsjOdHR5C2FSIeKcJEIwK/l2CPFZOi7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k107EVv9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=k107EVv9
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77B444056C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:42 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-82757b1535eso1164370a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792430742; x=1793035542;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s278JFLhezN8Gkm/FK18BymQx7J+8Zj8rnTYcg3SPnw=;
 b=k107EVv9wBKAjiQB7hVM2c+UNp7yjbFGBXYDr9R69vOM0v/SYemGTVAcJhRCTNMCyz
 OVnEbbf5ZwiNCvCEWw6dMyzaC8XfTUHCqfccqMS49MDBn+pBUZZ8gjiPrhTMFv9CGIkH
 2j9rGqZuPux1HUjLBC6zooxmX1N/i/iQm7q+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430742; x=1793035542;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s278JFLhezN8Gkm/FK18BymQx7J+8Zj8rnTYcg3SPnw=;
 b=INiilSD/h+nv2OK1y78kpnNfbcie5jETCLoFEtmGGZSBYxXWErjZmsGvCHIt+NuuXd
 xbf1Ss905bRqzZFrVzF2dHQ4iutNE1V9gPUmhvX0KEfmDJ4KD7py/pUM5+sOfa/xNnZo
 sp1my14FCqX3pmmbpjAROZ4qhoH1qEhSKqfU0tGYMOt8nYuGG9TWF6yjMpG1P8eXWH+Z
 fxapeAvFZM6h58lSWsNIwgjXd43T7NojI9N6NeVR+0ZisS7DFfo2mTM8alH0RP9qfiL7
 kIIAIRS90UQugxeoOUfNnhbNHs38Y4+ZChncHEXJppKxAjmqGQhBxkIcvJPIk+aNDJcG
 mEBA==
X-Gm-Message-State: AFq9FYKaAq0QVl+uheMJd3uNtRhX7il1i1AGXBdvNb2aOf0RavQk88Q5
 RYC6iiQabm7oJRTUwQxff2e1zvumxloNIN9/Eh094eiRMs9fMliS9NUTN13W5r/X/GarA0Pqmi1
 8iqzThQJRV8Pf7eE=
X-Gm-Gg: AYBFou3UhvlW8ZAlDcyv0Fcki9C6kYepSJwNEwKI47qaap4a5bLSiRSe1/Krwfali/L
 IEyh14/u4arwrYFQMlmHPdoXpRf01NwKn+mUP6Ey23iHOr7lMUqWv5Ch+leMSKU1v23366ikPL6
 1CEJOpUlR6xaicmp/OkGFYH9tnetABl/OjcHBHxeJ3uONfMAgwHX0yCxMLcYn7kVUEmoezFNNwB
 cFIVENpXMnKY1HIxzWNgY9wEAJPn/sH1tTtzQdC9MWU/+vQMz5f3UkyWZWG4aTz5Aw7v8STeH/U
 +Yp7m/T7g30aMWu8LeOn2JMydX9sI9wZZaxNxgsgB45yOwuUbJqAQmeq0UmeOURDlvl0a6JppuZ
 +LWP6Bistvj4jZH8hNG8Wxi8HVEfmZjtnbgUSoqqpBpso6Qb/lBabwZR1sfrtQlffYkMRwQ/6EY
 JOUbKrQRhVnTjX5lOWuMiul9FIM2eKapXIpkLAxlSNe1xT1LiGkc0aO343mmMOB+4oppx5B6oZw
 GNJDPPsvMe72T81jDuPpjr1gMNVQLKrAOU0nEoakXCnqZfPHaHS4mHc+ERLeauicaI+BZD7zFR+
 EAv6TZXvJ7X13uz7sA==
X-Received: by 2002:a05:6830:6ae9:b0:7fa:5c49:523e with SMTP id
 46e09a7af769-84503835f7dmr7842372a34.23.1792430741810; 
 Mon, 19 Oct 2026 10:25:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm6947094a34.19.2026.10.19.10.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:25:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261019153003.3719755-1-ilias.apalodimas@linaro.org>
References: <20261019153003.3719755-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-next-19102026
Message-Id: <179243074126.723589.11235889038726437307.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 11:25:41 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 18:30:03 +0300, Ilias Apalodimas wrote:

> A few addition for the TPM tree
> 
> The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:
> 
>   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


