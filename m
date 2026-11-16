Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2D606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gqkju8M8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=i0Bn0wZo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA72D80E2A;
	Mon, 16 Nov 2026 13:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1A1hmdFcW3gj; Mon, 16 Nov 2026 13:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECC1180CD3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834229;
	b=UtCZczmKSlsGyIet6bYTva/MUxJ/y3HxKzbyrUCPnFLSsAK3rMRgLuIwdZYt81P81y6g
	 A4KwvYw41RzbqCnfAgF7wdepPeGI8H5aT6bL+6a62+JXrfXOTbUa4pCq/mLwDSbXTZU0K
	 xfJYCq7RSoDUBUmya3unh+NcKkXNPVT4aPkI/0XklrL+7+hMdxp6sj6kCIRgaaraE/i49
	 ALqGsx+LX4FW57KW3hufq2GliiaHgej3zTYoYXCH1ztXPE2vMLNNISXK+6LiJ+OCjCu7D
	 DF4NADYCcmpR8jcQgp7YPzs1a62nlb6O/jRBa5NWobMPQ7ZRoua/blK0yyXhbgjCnKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1BhVM/R2qyQU7LAo7y3d8yBCgLYnwrYy7lODCyhiHi4=;
	b=ehSleNa3gjZNYuBiwtUCD2IZPp7ZRUiE0BYB8LO+/x43eWVyyDBHtG37oVPznLAtrF6j
	 rIRCInygJbfbvqM4eyYqUla6hH8zrDfTzp0Z9MWUrEVjYlWYRUhQl9PzI2ls/6RV/3jZd
	 S+QMSLrPkJvKRNgEMsv2gatWTKo5/WagJecf+2BxvQXSH1/R2wUm8Xo58TkpW9yTr1cho
	 7V6R7/uU8EoVggE8p6ylHYbudeOUfRexglvO1/TlrLj+PXIRNfwVgrthqEQsP3A3QxI0z
	 HMKjayLMvQu4OqIAkZxZbwkNkkM3DYrbaHHGVmaQkYlYWQskef+PqfV0AiQcwfkRUcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834229;
	bh=1BhVM/R2qyQU7LAo7y3d8yBCgLYnwrYy7lODCyhiHi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqkju8M87BdVPSePrD5h21vS3mIaGxjGWscZVRAgMIVhV3ixBThBDrcObDnzem3eS
	 5votl8x1Wv9BA+mX27rT3eByohhhjmfQClMu7yATjC/yXQihFSGR3GelaSdh5mtp/E
	 iIlx20u7WkdGMvpQjuEdoqMupKUzBeNZBnhef0V7hnX20PUqImBKpm+E/OHCeFEAtm
	 YvYMhXnB7vf2EArmNxG81OpmNAGKoMgW/yxoNuyvOgoI5Xd1OdzHGGaAN/qddMOyPX
	 1r6Ev2Nxm1L1r1oMiCxB8SYn+ST/RTzRg/j8f07mbuHU4T8Y/OmYApUNoy9XRZtfim
	 m7/jSIztKzhmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECC1180CD3;
	Mon, 16 Nov 2026 13:03:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C28B260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E07960768
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rTZIj9qnrcyn for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:03:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DAC160635
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=i0Bn0wZo
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DAC160635
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:03:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=i0Bn0wZoMuIe6PRRNjjPZeCgs3wRACsqn5eMdXaj1+OKzg6WnDBmDoGgoK/hCCj5q/eeDWE1HnZ42cp4tI2vrDkj/eF6vaV28guCo65+aiiUfB9lBAPodQnTs51jCc63JFtA3IymtQfLIjdvKWu3rEsvMJtcCrhpyTi35k9nxE8=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=1BhVM/R2qyQU7LAo7y3d8yBCgLYnwrYy7lODCyhiHi4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794834180110684.5288745616864;
 Mon, 16 Nov 2026 05:03:00 -0800 (PST)
Date: Mon, 16 Nov 2026 13:02:55 +0000
From: Yao Zi <me@ziyao.cc>
To: Zhouqi Jiang <luojia@rustsbi.com>, trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com,
 leo.liang@sifive.com, me@ziyao.cc, sjg@chromium.org,
 alpernebiyasak@gmail.com, jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com
Subject: Re: [PATCH] riscv: Add RustSBI firmware support
Message-ID: <avr-_7CNcFit18nw@pie>
References: <20261115171015.GT554944@bill-the-cat>
 <0E589B613DC4FA4B+20261116054232.1930964-2-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E589B613DC4FA4B+20261116054232.1930964-2-luojia@rustsbi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zhouqi,

Please quote the context on reply, so the mail is easier to read. I'm
adding Tom's comment back here.

> > To be clear, I think all of the changes to make things more clearly
> > generic here are good. At first read, it looks like aside from display
> > strings and a different scratch options value, RustSBI and OpenSBI are
> > interchangeable as far as U-Boot is concerned? If so, I'd like to
> > explore continuing down that path more.

On Mon, Nov 16, 2026 at 01:42:33PM +0800, Zhouqi Jiang wrote:
> Hi Tom,
> 
> Thanks. You are right: RustSBI and OpenSBI are interchangeable here because
> RustSBI implements OpenSBI's FW_DYNAMIC handoff protocol. This reflects
> ecosystem compatibility rather than a formal RISC-V standard for
> inter-firmware handoff.

So if RustSBI could be supported through OpenSBI's handoff protocol, why
not simply keep the current OpenSBI stuff as-is, only replace the
fw_dynamic.bin with RustSBI's binary?

From the view of this patch, I don't see any improvements by separating
RustSBI stuff out for the current situation.

> I initially considered merging the tags, but I now prefer to keep
> SPL_OPENSBI and SPL_RUSTSBI separate while moving the shared handoff code into
> a common path. This keeps firmware-specific details, such as scratch options,
> explicit and leaves room for other SBI implementations.

However, scratch options could be modified through Kconfig options
easily. Even with a separate Kconfig option introduced, others still
need to alternate it to use RustSBI-compatible scratch options.

So I think, like what I have said before, a documentation to explain
support status of different SBI implementations, and
SPL_OPENSBI_SCRATCH_OPTIONS' effects on them, might be more appropriate.

A documentation would also help users of boards whose maintainers
haven't/won't update their defconfig/documentation for RustSBI.

> If this matches your understanding, I'll prepare a v2 along these lines.

Thus I'm against the idea of adding a separate Kconfig option for
RustSBI, at least for now where it brings no real benefits.

> Best,
> Zhouqi

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
