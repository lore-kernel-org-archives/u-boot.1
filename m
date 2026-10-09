Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22A0CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A766181393;
	Fri,  9 Oct 2026 07:24:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDfG78UDzuOM; Fri,  9 Oct 2026 07:24:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C18228136F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530668;
	b=b8wH82T8FUzbGL2r7klsv/MEdF5xoQrN4ZfDgMc4WhhxIAD0UgH6Xh0qyJyYPmmZivvC
	 UMCSKk9IWEMZ7vmUDZ/S93ZsHI9KOdiqZWBMch8s0Kt/rVjI0Vg2swSmISQFt2C8qzvkR
	 0Oiy+VauMCAWidk7OVRlgoNHYcVYh1c2OXCY8kB/OFvqFfixED6HodWfbn/odFjfWjUxw
	 Kl7R27izbNmOU2945STmJrKYzBQsf3p9Xl33sr75yeElQNMlULIzHLGNkJjQH8m4Aap11
	 mTk/6aaHiPLJWrwlqH2pqwMlxAPeR+LXgr6+nLtFy/8LnA+MSaOYnYZ25uRVwnTYxLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wAkrDmeOcUM/StHBg/kzTbaR5MJwpJxJso++SO68Ju4=;
	b=LJbZX0iie1bNNgIM7+QoDVR0GCTx4eS+Z/w8riutviYl8RBl0cKtCgoHa5x2CLONxIRd
	 g1pN9ECu0MYDlkh2sK0NAKmmEHEqCxRQ+/5eKj+eQPN894QGELnFfkG+MErfifJQcWLUE
	 Qug37xnuQOEMT1dAvooJ+yUoquMlfzowo+K0f25qWs/k7CdhkHh4EinVRW33KVynwzE0m
	 PDUTKs6EXxOg9alSihFPq9DLab2zgetKZ29HHc6uXz4Ya9rHDpQxXuEJSbIOBt6L2F7ZE
	 fkjP9DyPMEv21OGSn5tOJ1dp2aPYEsBTe0lqcuPyHz+ytZe0p3L9PNszNt8wwfdJrEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw06n+3j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530668;
	bh=wAkrDmeOcUM/StHBg/kzTbaR5MJwpJxJso++SO68Ju4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JmG6fhnALzTyC3GP95OiyNX6pecpulLCDwe0XrNY5VSAhcmz55n+ePEWEqmBRsizm
	 2I1/G7dHCFWQo+HwtAZOQNi8gHYmEu48R2V+ulumK4Rc5LYsyB1LwYooHwF4b2Es/1
	 z9jA74eolPGEf4Q0zCc4DLLf5vbIeHGZOvkzLG6iREeag5kmWfZIJ8TMiG6K3FRP8I
	 7YWER7DByvhV+fQpZldJh4LDdjMB2Lhjmpp/pawJ4P7vHXo4rpu6On0ik+L/J7HXkl
	 CGpdnuCzx/vGbozE3yvbfqsx417cJFOmw7YZzkv1gEHSlqogbJ3QdU8eJRu+AlP67m
	 9N7kFh5GnITIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C18228136F;
	Fri,  9 Oct 2026 07:24:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF83E2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C139C8136F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:24:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pRTFaNdWohoK for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:24:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15FCD8136E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791530666;
 b=sbSJuzfsS7r8rS7vHLb36B0a5oRybUfx71xVYKM4W4f8Y6jfscE2lyG2dHNNZSV/PKQ5
 b35gVJMfQc9rlmLtwhgz6bq0B6TqQOvWIiFdrZjG23FL2cXN6tr3imScX5127d0tXpvm9
 hB1XZPN5z/1UbvA6o0iuei8MOMYVsbHfzqkXCazynj51neLk++tT3k5EJhulX3ukNQRrb
 dWbV8rXIxJsSXLfhSbpLdGfYY/2Hd++tFDjQE9YQykGzzbT0ZhFT4bVeiV19ot5VxmdMo
 3ysb9hNvYaIbU5csSHaDkwafBQoR2ZGyTd/me2zHRiCI2tEUKJJqR9hq8VZlr480B7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530666;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=wAkrDmeOcUM/StHBg/kzTbaR5MJwpJxJso++SO68Ju4=;
 b=efzOm/dvHsgi90ZMlWQjCKN6ogXtwldNQ3CsZJQxjRR5Nz06KRL//MRIxXRO7qC/iPKe
 asDBqm1N603QZ/lfZrI/Zpn37xkKyqRbwq1tUAq1thB967ysMDwHH7bZ2DT+AZ7kH0RZJ
 qzn1UtnBAx1YBJrvuFomjSL2vWcnidCiAuoB4L397ykQAPyJ5wpGwzvnfFg06thRDiAYH
 ehhrogWqMpe4xbr5xJPF4Xjo2kYtZinS2/877fk5xZcIjwFU97WeVg8P1N5aKa2Rff/P5
 fp9snOg6vrncfkrMZK/1K+yU+ujj21kh4RnfC1XSORZpmwtj/x9+80Vu3+Jb3Z923Aw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qw06n+3j; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qw06n+3j
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15FCD8136E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:24:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49F044037A;
 Fri,  9 Oct 2026 07:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B7E1F000FF;
 Fri,  9 Oct 2026 07:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791530665;
 bh=wAkrDmeOcUM/StHBg/kzTbaR5MJwpJxJso++SO68Ju4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Qw06n+3jn0l2RLLXYZ7t6ematMKbh+lsIItG4IrWWzshuoVGb0ZeA4yoO0yQDJmh0
 xBWqdiFjImQwsYKp2GZB15zlR2d/XYhycnu9uuKwpKRZotvC+YLBJkCzc38Rfr55i+
 ugoFkwM8+Kg8GWv+87av7HWZah6fMlOHFkM86nomYqaGZZzTa1b45Nyg0M296z48aB
 ekxhPNJs5Kj/4KBrfW8kl5VJCLMvjN03lQU4wFEOkX4Gp32/dKKs63lNpu6cxqMfwe
 JiBXj14qpT5/QxExE39OkSqgEXD1yDH6ZDSUuayYHcBb6RF6PhcUJpmIkN+RzrD4Ns
 eohmO2/q2g90A==
From: Yixun Lan <dlan@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yixun Lan <dlan@kernel.org>
Cc: Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>
Subject: Re: (subset) [PATCH v2 0/2] riscv: spacemit: add pinctrl support for
 K3 SoC
Date: Fri,  9 Oct 2026 07:24:19 +0000
Message-ID: <179153062727.118592.11788015093281330367.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
References: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Wed, 23 Sep 2026 13:06:51 +0000, Yixun Lan wrote:
> The pinctrl controller of SpacemiT K3 SoC changed its register BIT
> layout definition comparing to old K1 SoC, has different IO
> power-domain tables, and extend drive strength bits to 4.
> 
> First patch fix drive strength configuration for external-voltage
> IO pins.
> 
> [...]

Applied, thanks!

[2/2] pinctrl: spacemit: k3: add K3 pin support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/9fd9df71e2435c5723f8a8fb2a56dd27577f2418

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
