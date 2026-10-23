Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF2606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rhHQW8ap;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZkyp2zr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A6368121F;
	Fri, 23 Oct 2026 01:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E8uj4T8F1xYC; Fri, 23 Oct 2026 01:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB80D81211
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792718265;
	b=Hx0K5fDfOPBKaWvAT6d8F5+DTr477m0l3S+eEMxXS/LcTpjmtQJWzXptDoOo1OJTr7tb
	 PryEp3o3kyOqgwiKFKUAP8LQAzrCkam4bAoTTtow6JZKkQMBGA/QCdNGY1ihuq34/rh+y
	 hsO9WUVt/fq0ctO6LcplrDTqocp4iJqq/CJk6R0w60KMujXMQ2j5C9WXXz4Sk6oGKUob8
	 BjkrLUmNXU4PiPo+b8x32r0CrFu7cs15nnPFAEtb0jVliUAO5+8QqvWPq7yi5SnPZa31I
	 iia2Purs8fRpkndITFriRCYLIK5o6vfr1t4+hFRli4CvKInflNa9+Khpb7XsCEOJlJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792718265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b9CZsvlBveIjYYUJ3krHUvR6jyHCMWPyC0tI7tjSauI=;
	b=kU7i8k+cX4dDFaS2XV9IC3elwN20sD2+pQYtabu5iK7AmSsbJjiOxqkbhlJXx3rvif0q
	 iIlQVxg6wB2w5B02+H4MH16fLQNtcoorH73vl0u6DRlz8ntvwqadQ3oVgyvgy7LrVbWTF
	 V/i3M1cKGHFFi9LGWXygzf7uUkOoiheoXb/erccXMwDjyvfl8JSEpdukmtGCcGnjCLuIC
	 ZQ+Ukv6/LWtnvMOw0dhlEPq8RRkcr762n7GKx4jn3AV2LV5cvwYISmcqm89LuvaxIP/bH
	 Wsg03XJmGCyw8WsH46XMyAmv+Ho5eUpxvI6ZcW+P9tOeDNpveS99f+0yJl+BGL8zOEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZkyp2zr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792718265;
	bh=b9CZsvlBveIjYYUJ3krHUvR6jyHCMWPyC0tI7tjSauI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rhHQW8ap5U2w+3gj2P+cRR92gnoZ6fIdV3tx6I50GI7Yuiw1GltMDJocw4PTwGsiG
	 r0AEGtpVe0maEw04Qr0XhLCstb16lwBkU0NeNu+jUwWos25w48Xdb9J5lk2o/rBFmS
	 CWCMrw79H11CQV6+UQKWCyngiKmGgDn0wAs0yxQE//DGgxYgfmpiTJ/VlrSSF4ZDN6
	 r2CnvTQY7gL8a2FV/eh+zAbhKS6fC83Tl3OrWR7YnhtiyJR+hLlsiGodHUB7VrPKKj
	 lXvD4xQsxXGDkSED2mdiht1t91vAndwuvyrlElG6xdAuKwuW4WtKMey8MEDAqJGuTF
	 2wiPURlqSbrFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB80D81211;
	Fri, 23 Oct 2026 01:17:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D7D74D1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7FC781211
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avbrmnSpjKqv for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 01:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16E0780D6F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792718263;
 b=m0EnhAMziud8AAB36OQKlN3iYUKhM1p+UtW4FIDqW/EwosEEVT382Vpus98W3ZSwon2S
 0biydA0OwY6G/D1Y+V/BHcfzBVEp0E12Tgn4FvzoJHGnpatHpq+jIuFy5PcZYqpmK3F3g
 Zr6ANRscGmZzUyaCu9hD3D+LjkoJL2Ez4ORukZ5DRbEQBUeWl2jK737/o55eNdiEeFi2q
 oidoU689evQREdK085qtLzgxge5voZiK8vcpcXAbN/oDHzcdtUxn/c3IWy80b215XYMic
 XMG0GLIhkRdj4sYF2vcU04782pR2iImBhsufJ4M4wcoKNgk0bF7FOFgQ3ZukGy8xpiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792718263;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=b9CZsvlBveIjYYUJ3krHUvR6jyHCMWPyC0tI7tjSauI=;
 b=JoOVFSX81bSyxFqQFK5+GHEDY8lc3HzDxMcjSQR+Wqw3X2AN6s/fHn1dFgnE9wnRHw25
 H2P82zQV+19m/gccOmuAxPyoaRXclns6Q29plEu/EvijFAMbbUkKcY7w0oaROeRP9aDFU
 Z7PXoiaFxY8eO7ZMoBmjj2TMSgvQxG6Mo7vekh+KaeYWskSHstAuU9AsScVLtmu2coq8D
 ikhYF/BMPGuAjVW68kw6L5NKZYsKgVW/qcOuDpbPESOb9t3hykWiKtDS86Zj5dd5Zx3GH
 A191gMJv6v46mqiz/t8IzHfTqYPfCYMTyEKEupbVkvjxUk8+MiNoYRM2XRuJqcHqv6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JZkyp2zr; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JZkyp2zr
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16E0780D6F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:17:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABADA601E4;
 Fri, 23 Oct 2026 01:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846D61F01825;
 Fri, 23 Oct 2026 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792718261;
 bh=b9CZsvlBveIjYYUJ3krHUvR6jyHCMWPyC0tI7tjSauI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JZkyp2zrckm7NCnq498N6SexbTbF8g9hbnSoM0jzuEJuLvBvqbsuq8noP82VkZKg/
 ZR7GV1ar3g1T9xxJ6HrJe0loedXYPKOzeX6a2Lsn0Rj12iXF8b9htsMZpupieV5rwv
 l7unmgoqI0JoODUB350iy9dIZ2pHcDASTtG0yOm+0TS0GO90TA7hP709HOIDmnIMc6
 KYyt5QSVHOWZ2spR7h01wQkDJ5s9TIqnzAifzQfKxtj08QP/cU2QVroRnFcp+R2o6V
 erznJNQ+OMGpwnT6GSbisymmV2O5CNIzMv8+vnpnN4Uug8m9rXNNbi/q2kj/W5NZTj
 atR5p3/Yaqnlg==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	Dave Klotz <DaveWK225@protonmail.com>
Cc: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: Re: [PATCH RESEND 0/2] spacemit: k1: SPL robustness for boards
 without a PMIC or SPI NOR
Date: Fri, 23 Oct 2026 01:17:37 +0000
Message-ID: <179271823735.299372.3589567158983015647.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1790976767.git.DaveWK225@protonmail.com>
References: <cover.1790976767.git.DaveWK225@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 02 Oct 2026 21:32:56 +0000, Dave Klotz wrote:
> Resent: the first posting's cover letter went out with the same
> Message-ID as the cover letter of "pci: spacemit: fixes for the K1 PCIe
> host driver", so this series threaded under that one. No changes.
> 
> Two small SPL changes for K1 boards that do not look like the BPI-F3
> and MusePi Pro:
> 
> [...]

Applied, thanks!

[1/2] spacemit: k1: do not require a PMIC or an SPI controller in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/758250c6f99e33088ba3b7430532c3ef5dccf7e8
[2/2] spacemit: k1: fall back to the other boot devices in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/53d5fc5d42bf31d3e627bea34a5199d7790d9f43

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
