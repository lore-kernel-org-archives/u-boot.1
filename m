Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EE606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cL3EiwZJ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrZfPOTn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD383409B1;
	Fri, 23 Oct 2026 01:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AksHbv4af3RB; Fri, 23 Oct 2026 01:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D714240959
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792717897;
	b=L5jseF5YPPJkUUoSxk9e0S/H0FsQNXZSWauF2U2GvMxXnIIF+X7jBFANTq7O65lkHYDa
	 EAoKGhHYuldfaLQYVtnXS2lZXh70AtP96sQ27DdWuQx7yxwLGXHXIMibcK7llmF+admpi
	 /sjbaHnWrWit+ZujwwWmYPRrFt0RO18qk9dJIViROyWxL3GmC6TIeulsv1aNQzywnSPfk
	 1+gITm05WVwdNZMHMXRucWigDNz6JC5ezSVQRn24QGd7AzRfI/v9VnS2IpL3hJ6LlQ8Yh
	 E0d4JByBjpZUEAWKozGmpuDTK1BAQSg4oISHC2jiL6d9/6lBZJej4FuxX0MMhLuIUkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792717897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ca0MKmziHGn/ENW6MtF0WQWdMBBji0twFfNmZik5cvc=;
	b=djEfbwXgMOrMRAHZdx6ACXgFQPqGN4iXzSIEvGNw9Q/flU9WmLqYOp1uDtfTSqyP9xsL
	 arX5Hyq7U1tnhMj4B3SM+5FMQbVH4kbrZFfVm28vmmx2oNIIHLfu89wC5CCqlm5pDTJIs
	 sIuJjoP23kC00AUXbnCqV3QGqKrBPLoPgIbrJ4YOBSUkjk/xUXdyodbUUcDCS1BM0Y38P
	 cEzl2ci35VGKpF4CugdjNpFehtkhGhW1Su4ejNlLy7fr73hEGLAZ6K7LQIcC0xa+LwDc0
	 T+NLoGhA+plxOqQ8rC7JO0n2I9qTnqcGldGObpBcTng+D5YPDDoCtRCDtPuPtqORo+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792717897;
	bh=ca0MKmziHGn/ENW6MtF0WQWdMBBji0twFfNmZik5cvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cL3EiwZJLPdFogEQt6RoenL4Zko1ljr4V8p8FlN6pFgLxJ/pHBBp05073bG7kbD91
	 euVVNle1Yy/Old3ZSFsbe/GBZMf0KpEaHJ6VKL3kKN0R+4E3CWBfP0v6KVxoUhxgXg
	 G0UYfuv/fJrb7Cu6pd55OrPFf/H0MSS0hLje7VehffnlmL7Ya4MFkfVcSMeYny5vRk
	 MyEMrja4OGRaH4DvT/7RRNNT7eUjvEqeHAjLfDErOY4XVsgIqSyfcMFBeA8EjB7X5d
	 +l1EhhIQBHvIa0PRddbhEUuBPSt1DgD0cCcNv+Lz+nnA6qX18Y/0I73Y92k5D9lEgx
	 JFB1TZIDOASjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D714240959;
	Fri, 23 Oct 2026 01:11:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C243C3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8491400D7
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:11:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0CW1jtLfmdb for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 01:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA1C6400BB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792717895;
 b=o7ws3TBYDYfRcp004mnCZVsPt820bhjOEeKhMF55iQkXVP6rALUhR0Kb3FRG2rz9cA+y
 EcYKTc6BpjNwJPQpKw7gnP91dt8n4PEoC4GH8PcK3/z+XrpiOP/TVdF28rO87Mw4aOizk
 NGkQD0Ss6uXBO+IhEzE6gmYJK814M8XNqpnGfASlC4kvFUUQb5+zGR+YKmt6NjCM7dLMk
 2VCjfUXqsLr4rJDVZxBu9MTbakppglUufYj28SnrjPWbk+HVu6hesusjrOf3fz0oLeuQu
 oSbzU4ph6fhW+dk0RKx62fD+MRtQK3uIJcJh+bfiBBJLRazwPFVw/QNqWBEO9EEtPbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792717895;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ca0MKmziHGn/ENW6MtF0WQWdMBBji0twFfNmZik5cvc=;
 b=OqlBHfPykk2Mvk0FjvkCS1Ow44HdhKW/YCc54bNu4E2U5o88Yq3W1YfUySjHQYuL8JdO
 VZUypMy/JBsHn14PXO1Qp3/Jvhx6TD7FxLyzAwKVQjEUOEvj/8+rmciHNJaxus6cy8sA4
 svoMYbihHwovfmlPwnSde9Qvvw4tuWLV9tiLwveyZ44AKHBa/84wtxjkMutvdMytdjR/Q
 vV6Je5Loz9zlyfVkrLqlk4tJRrc5QXXaDeta3LalZKLPRjoRrSGJgMBMxX0vM3TbLSgO4
 Z1SmKPQzVMsUTMjA+gFmE2QJmNZ0bUPfKhJdhlHwf64mPdBPs0mTviXWehHKuZxMj9Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FrZfPOTn; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FrZfPOTn
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA1C6400BB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:11:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05B7B43993;
 Fri, 23 Oct 2026 01:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5EF1F01828;
 Fri, 23 Oct 2026 01:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792717893;
 bh=ca0MKmziHGn/ENW6MtF0WQWdMBBji0twFfNmZik5cvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FrZfPOTnVfZhsxv1GNB7Pt778yefpphIIR8UKOhtzih8FJJE1c7nFA8xJax0nL2mV
 1eSLgJSbWwe90kn9rZw9K28ri9aIecJXeXDbC35es3VUHxv1n3oHR/9jEzQLU8Q9pV
 m+0U/AfSKFI74782fBWXBk5k9JhBZbxrkyZZNiP7RqCC4usMuRXOCLMsV/geevyg1a
 olCbWUxMF7xSkMRTQZ+xk/qTr38V9RxRU/Q/KvzGsSzYecy3Q8WPFwg1NAXCyGGNXk
 aMcI00PnjXu7+hzphd/BT/TO3lzz6vfx7zhjt4rtRchggwSMJnsUwn9kGdxpVvhBS6
 xPfmoB+Q4IApw==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>,
 Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
Subject: Re: [PATCH v4 0/2] tools: mkimage: add SpacemiT K3 boot image support
Date: Fri, 23 Oct 2026 01:11:27 +0000
Message-ID: <179267091870.88099.14500651911580762927.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010-spacemit-aihd-v4-0-e7152ae4d71a@pigmoral.tech>
References: <20261010-spacemit-aihd-v4-0-e7152ae4d71a@pigmoral.tech>
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, 10 Oct 2026 00:31:06 +0800, Junhui Liu wrote:
> The SpacemiT BootROM loads a first-stage bootloader from storage or over
> USB in MaskROM mode. Vendor firmware packages this bootloader as FSBL.bin.
> 
> This series documents the SpacemiT boot image format and adds the
> "smtimage" mkimage type for the CRC32-protected K3 variant used in
> non-secure boot mode. It provides the FSBL packaging needed for future
> K3 SPL support. Select K3 with "-n k3" when creating an image.
> 
> [...]

Applied, thanks!

[1/2] tools: mkimage: add SpacemiT K3 boot image support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/1d43f1c5f35614ef542532d563166c2ef8cdcbaf
[2/2] doc: board: spacemit: document the SpacemiT boot image format
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/b0acc14b606ced3c76c43594a474cd80fc791f4a

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
