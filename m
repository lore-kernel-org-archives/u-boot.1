Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48443C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 16:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDB1B80DDF;
	Mon, 14 Sep 2026 16:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HjZp0SZtL0vT; Mon, 14 Sep 2026 16:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EF1E180C95
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789402756;
	b=inDooYD15qo0jYxba00ZB3mTjRiUnjP4UGk2LzFbW07Rnp7ynkBrbMKp0AekLcv1uxii
	 cKWNq0VMqnhKWCxtWK7HEqfyQlKlZQhSr1HcvcrL7oaKMbvKxkbKhTWXdZ1+dRJvudMY8
	 cuWdAJ3w9iSfqIgdWpeY/af50JWdBbo0uEFqzVHTyNLPAfxZR0Zp4yg6EkH9gYKVOgGhP
	 eGMbMelrfhTN9D6X/aAe2jXGPiWKaj2f1DcmTwDFOnyEqW00tcZ506u0/zDqok72dCKPy
	 xj22A3Ap0L1ZNEDLQRMQIj28N2byo6Y7LVFknj54NM0r5vhKlye8IHXd9H4eH9QDdBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789402756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VyL9QPEL1B4iWlR6FHibEaq+mGrCQRQs51oeyO+ns8o=;
	b=qGaiv2WBH6UzGgxqxS+qwwaf3wIk6MjxTEgnTVfGBR6h68zEyGSAlj1W/pPBvzK8xCqQ
	 QTQj2QrmF1xsbkJS2uDFLniaYo5HAkKlw67xEfQhorBCxQwCJgvkK85zYDtpDZZ7HOzWT
	 +rP6uXeQK7FZxUcVbOpYA0UAbRMWeR75yoYn5y1h5tdEJrWJ18P7P0J5j5Ctx3HdfNqRo
	 WaBs7siSS1F+LGaL+mG4/yyNnOLT+Qap/iJOdgh+txeVyLY2GyVb4GKSBZBL8Ac7VWMSg
	 QdrLhHSJqsQGQHBkYaTNgVTc8Rwywd0m3wbI+yy3RQ0RgfhBO3ZivSLSQgXUoBrZl8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789402756;
	bh=VyL9QPEL1B4iWlR6FHibEaq+mGrCQRQs51oeyO+ns8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5zFePJg8UVWQopZQGT0515dM5GVVYKbdbSDsv4+80nZp9VAfz+iUPnTslL7y3MiW
	 JVrf3DLnYiFgTKUCnDQGJBIc1hJxa7tKjmThDbPDL+lyq8LBDTnzNtunFUDBReqth/
	 O/mfL9g5dKuHw6efNILKIPc4raAEVMf+GvrGbUrPvvLOq3GN+mZPn9wAe8Qjs7rIaj
	 XGt4bWC+uAqIUwv+gERJvk76VsHFp+fS/MCS/u4xZg4j5XpUzB11ePaEpa0LextdYM
	 17Fy2cozy47uwR+WmYeHtShR1+uJsn3B6zYMwFNdOtxOB/dYE1i9ge6dHVvjLNG/jO
	 04DVUGtGGCHWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF1E180C95;
	Mon, 14 Sep 2026 16:19:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68DD6224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A4C84060E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXI6kziDDoXZ for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 16:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 87E5340608
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789402753;
 b=Bf+cf97nbO/3hc2nHZeIEJ5c3sqPJJAYBo72jgLdfq+4f49/fFFiC/GAk7RPKRDaH7yD
 nDNQsWeceCRPN1XYQ9y5CIVSpndpZx21Kjuo/k7HmOqyMpsdDKWNqMLR7jLy5z5SffZmv
 Z+kfrDP4dRrqu6HcwJulKuZ0FiJC86fYNYi4E1AJyK+RxYTW4Bvg2aS4HfZFggZbeOP0O
 BgiYHSFXB+XFVfzLRGUO0VPLkBvHkilKgXxkd/uRCMNw2z/PVuNdvqvmbF5uj99Z8FlRy
 yjp+s8xPDNmm1+IQxvXW3mbtp4DyL99siR2RLqbLb7/o/e1hG4uCGslszZBCZzAN3XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789402753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=VyL9QPEL1B4iWlR6FHibEaq+mGrCQRQs51oeyO+ns8o=;
 b=smQU18Wp64ZRPcjubLAt0ODXsPVDQxBHxJwoXQYT9JHA6qQJMrFXPnhiEoco/qRLzGP1
 DnzxdD9wYbdS8yy9lEz7nt+UAUXb5Ef1TjEkEvtvKCK/G8kMlnMOMFs3MIAV0/uhzoweq
 4uG59K3alUvdm45FBoZtEzRHzDH0ZdCQ/y/OZ/BEWskhxLP8RbJYmRrbEXAmAoK2QbNnF
 hG5GX1G6EngJDn8aNx6RINinJNhCuEh8iXVsGUsSdX3dnpLRfsjxZBpgnLVMwQk65xWtq
 N1Od0Jz1uT7+4NpKT4+/dUMuYGDqNZmI93a16FdGVy71xP1BFP1xF6OnvVcdM2RAInA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HCUBnRD6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HCUBnRD6
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87E5340608
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:19:11 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 006d021491bc7-6aaf6076546so1882873eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789402751; x=1790007551;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VyL9QPEL1B4iWlR6FHibEaq+mGrCQRQs51oeyO+ns8o=;
 b=HCUBnRD6UXUMqBuOkiCQK5z4Unr2EpQaz2ZWU/wyipYwesh+2t1C64m4bKGjIgWzTJ
 KDLK+N33ql5U67jzCeq9ASjImjDZke1fPqrH1CJVjroccVRU0hkzna8tspb6lOEQfa9J
 grS6h4YK9AzshfKxqMkTZ6twu7AHyTiQQ+f+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789402751; x=1790007551;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VyL9QPEL1B4iWlR6FHibEaq+mGrCQRQs51oeyO+ns8o=;
 b=cxzCdIiMTVQEB9mdQfVzgbt5XaX1a3Mq5PEwznqO70l6zT/F0eKM+CdX/p0Aw1fUOf
 wEm/ABIqbYAItGGnoJFqc4G0h8H2EbI3PLY4t4ePHXtnamHJEHY4Vb5EfHjKoH/x1QSF
 +5hr1MM8Jhcaj6ztgRkagNHYKW9VbSOsvXMRTfaltshQKr7Byi3Q7NDCCzH3RjMWfhUA
 fBmzrkg7bCKtxWYSJ2ZGOqALXn4mRgkd9quKr5p70sif7FyQpaX/H2zgss6PKkG4qB/D
 WJMKKA0Nf/Stqwe0sP74+854b837GfnQ+M8OFy90PLEzJLSTwNvXOUfRHx+bP7W8RQVk
 Owaw==
X-Gm-Message-State: AFuF++nz1RyiDNavtxFOTbgH/QuGMaGtdFx/sZV0Rs5oGXXQ3yEuy+Jq
 6rONbWSZIvpP2w2nx4ixtRnNGB6gmHbdogo2/JbkwG019IcfIt3AnhYHWxgAcZamV2S+bA6NT+7
 sTYhOmtbBZ8VEr0I=
X-Gm-Gg: AYBFou3/m9ndL4K/Ky7JCD1DCfn4+zRbo86tTz4Ip9v3fAMhg81LyJdRNK7ve8fTBv7
 J+P3z7N7jPOzvhaBurK+MGPXcDZyzkyJfcNhDAL0IwkaOVoHIwdvVpSz6pLRbuumVwYTQRBQmMb
 gwUy+evkNI/f6WATJ1oJ3OJK8O8/S6NAgZVyRhJEQ6+aHsJKof68eWoCz/siL+fhUN2LcMncc8c
 0fqTh5f4QOxz/XNgDnnGUDjRTBhz4bffcKsHHeVYdz7vkT/d/zoGBeSiYZrmPwJmcppr49wfAfw
 Ks1HkLFhZhEIXMcYxdkSFFDssXeh2t44iYXESsY/uu2FFBJMdMze3Nfmp4IPiWZ8aGMMKd4+Jby
 xrLpn6QZLHCbAafq5M5jtaEornDC7xQBQbpX4gY+L2xdxRbTZE0tTyhG4kq6Ei3YU3zuf0roPcY
 AwlosuTG7APHrbdHV7v9qWi+sMz3DDCSiPbqwlZKMYNU1lRNa8ED/CrljtARH84SwJvF7rchOfJ
 lj+dMzAqWX25JKTGCJjiMgvi5ToYwPZzVw4V2kOD80MwpP4z4dBVyn712u+y4g0BkSVD6CEUlNN
 y1vDvWnnUQQ6jw2wL/k=
X-Received: by 2002:a05:6820:1521:b0:6ae:5250:dd1c with SMTP id
 006d021491bc7-6c542b2f93bmr1944725eaf.29.1789402750828; 
 Mon, 14 Sep 2026 09:19:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c0990cc05fsm11047214eaf.3.2026.09.14.09.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:19:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>
In-Reply-To: <aqfVPpJqQrdOiAOL@nxa18884-linux-1.ap.freescale.net>
References: <aqfVPpJqQrdOiAOL@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-next-2026-09-14 for next
Message-Id: <178940275004.445362.13703614738068104709.b4-ty@konsulko.com>
Date: Mon, 14 Sep 2026 10:19:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 14 Sep 2026 19:06:38 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-next-2026-09-14 for next
> 
> --------------------------------------------
> Adds the Free Mobile Nodebox v3 CPU Module
> Correct SCMI regulator Kconfig dependency
> --------------------------------------------
> 
> CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1271
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


