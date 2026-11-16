Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C1606A333
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EfG8zckz;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=c3KjNamx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D9B680D62;
	Mon, 16 Nov 2026 16:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_ushAFI1rYx; Mon, 16 Nov 2026 16:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6518580D1D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845646;
	b=e0Gkmg32huTSVVsII/G/q7nbJdB88kvIJisJrW9zPU0z1Z4mDG4l6zi5zOAIuxwaJ337
	 C9JR9FNZ6w0Vqigd//aFPBBgDnjVIxmorCoc6O0zewMHzoiPLiLAD8k3e/aZ3aqGnQUlW
	 VxbG/WnmFhWGkho3VPDSgQfvlaY5pPZsNlHwePhPsw4FdcdaY/KAEX7pn5mZIgGxPbLof
	 yp7lh4X8Rz8+P952zOadz4h8fhIonMAojIgJQ6W331DkVAn1e0d9Hiou8wDDXhdnWkcaA
	 zlR0uW0CPN0BTDTaljdcfhjRK8Duthh5Xeu80wQB4L4oA+GLmVx5yUxq3ZRdHSMHLgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ag4qRR7saDH0S74l+EFBdLOOpYRUtrKotrln4VZZPA0=;
	b=Cp/yFdWkd4sANtjk7/hRcWHYMjzO1gv7UTKLfKPk62+Wky8fzqdzYxfZtcVRCH7s+QPy
	 5BD8K2PQPH6p75PqFwW8cG0gFTXX0h5qbdIGqPqrbNyY8UxXl3Pnyk3BUyPimgAMXuvqq
	 BgNuXCfvwvSdY4dVOxo47bQ/AGvUTU4fLPMHcNv0y5JfX+uyijr0hF8ZdsfApDe3EdNGf
	 JA/GNMOQXeXD1vlRjX8R1mFbLtQ96LAtQPt9tV7Wi8MHtbtjWx8e2DgEX+HiUtOv5h2ij
	 YvH3y4Xro7XRXEYHdWBCXQV4uiunn/oEYfTFAh8jRuR7em6pJQP/JX5F89ueQthQsyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845646;
	bh=ag4qRR7saDH0S74l+EFBdLOOpYRUtrKotrln4VZZPA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EfG8zckzF7wORZnlAtx3Yo7Xjwc7vuPnOgY9PHZSO3BjPbiAreqE+jnEH1l0OOhCm
	 K1xhHPyhMVZLn8gZj+LQwHjnVJLSNLiGF50O54+7ww82TJQ4ZDnVmdSbNkkgTN4XZ+
	 nQ9J+Rq4tX5ZtARNKKmZp+apSLtQkAYD+iYC3Ou4cRNjF9ASsB/tDgClzYRcGk5ONG
	 M/vD5wYb/VldJG+auPGdyYP39Cm5jQ/el+Ge9k8sVlzGU/ZSytFtx9u9Z/0BHTUVf1
	 UGBRBX2QV79WxohLr8U+XQWENmb5GSYrojD0aawBYqgXeFPaWx9rAHTLnV127i/VIA
	 OooWMEAktM6Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6518580D1D;
	Mon, 16 Nov 2026 16:14:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CF2170B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1255340790
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6LIDzACLrNO for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF42B4078E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=84.16.66.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.171;
 helo=smtp-42ab.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=c3KjNamx
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF42B4078E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:00 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGG6R5Xz2Mgy;
 Mon, 16 Nov 2026 17:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845638;
 bh=ag4qRR7saDH0S74l+EFBdLOOpYRUtrKotrln4VZZPA0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=c3KjNamxl+g3/NbtReX27YdQY8Kz1hS6ZEB+l2Nxur1IU+oUNejV31QEyX83SW7F+
 tzKmeHG3nwPgT7IFOQ7NaWMYxXFntCV9JEahdrZXgzda51CGrTqXkOJHF87UIn9jPz
 t6rCtcC3mnLRpfw1lAj8uawxbEI+1ws2VSQl1P9qUNqnQYB71OfjA9FQEFOix8Zxa0
 gHMW5owlqFq4K1mfAn7MNvTJbAiKrGCVGnwqK0V6Ai0KJ/aiCcixkzAsvRLoAnAnrF
 Dk7TSl4JkTRgcaCXPBP0taPU0wD/dPW3zIWkdqe3TiC2lfmtaZ6eeNQB4zyGACM9Ty
 xKX1wbNh6jC5w==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGG0BNjzxCb; Mon, 16 Nov 2026 17:13:57 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@0leil.net, Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com, 
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
In-Reply-To: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Subject: Re: [PATCH v7 0/6] doc: clean up README.rockchip
Message-Id: <179484563798.1840799.15983409978499820835.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:13:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 15 Aug 2026 15:05:48 +0200, Johan Jonker wrote:
> The removal of README.rockchip is long over due.
> Prepare and expand rockchip.rst with more info.
> Move the still relevant parts from README.rockchip elsewhere.
> 
> Johan Jonker (6):
>   rockchip: scripts: remove rkmux.py
>   rockchip: doc: add mask ROM mode text
>   rockchip: doc: remove TODO
>   rockchip: doc: remove README.rockchip
>   rockchip: doc: add back to ROM section
>   rockchip: doc: add notes section
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/6] rockchip: scripts: remove rkmux.py
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/03d7313ec2322e49083702aa40922ae1093d31d5
[2/6] rockchip: doc: add mask ROM mode text
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/4c26938680bfcb35bc2caf35002fba354c68b709
[3/6] rockchip: doc: remove TODO
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/e0b7b28947532199ad2eb1d04df6cb9e47cfcf5f
[4/6] rockchip: doc: remove README.rockchip
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/76670eb51272318fdee3d977516742155caa335f
[5/6] rockchip: doc: add back to ROM section
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/a70ce65eec42327c425fc0270cba0868a7b9a131
[6/6] rockchip: doc: add notes section
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/8d17a5c5be9332789cc050f637a4a084c88ac59b

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

