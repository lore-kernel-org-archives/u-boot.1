Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF382606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MWqpjOdW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nn9OpXz5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9754060896;
	Thu, 19 Nov 2026 09:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B06FgZRzGX00; Thu, 19 Nov 2026 09:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 57761606A8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795082077;
	b=ALz+JHfpY8432ClL/8AF4pgK7LczfWs+8Za87b/sFQHCiHdSK0VL1UaQZq6MBPeJY3cA
	 HX5qa3n0OLW38XfocoPR+MT8BUeDpnE9B+72prnPVJAFug7ovkww5Ii7XzhUhATZYPgqG
	 kOLMcSbEEpui8Qrdy0Cmrrz1SywgfarxKngyqU1eowXpco20QBb6JtVSqX0qwqsKkSLvJ
	 yNfWKcTcaxstVzMQ6IQkEcDZWQzc/H0U6Dgcb1x7B0C7GnUdcJ0/E2bimg+cA52sgakDO
	 Rw4LCe5rzqFQsNblN1KWoEw10avQvXrdhuWLJ9cfV5Q1T4+jugPPIEjk4iJCN95S1Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795082077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3cagBWWIABFgbwVnKdQmPzWl/TvM7jmgNAN8EpoKaeI=;
	b=K5G1OR11mx+JqDgf2BcHIK+jLGD27L24gaM78C9Rr7bWgGHuLdNJh3iG3GUxYn43CFab
	 fUhbRDFGAauMAEeOMtzwY073dcJ7eK5HZUogUpzazNWJOqNn+uqc10DQSUpFzFjnynj1U
	 rAfx91VKPSqBLhTuYzcntvNWMCiq2jongcEpLn6ZGTnxcemozWRlpRG0W8svIchw13vTx
	 YrX3po6CzupyK02YlgvvGQzSq3iOldwBl4pFSf9g/W8il48Ks5A5Ek+KNSxSPIOCwC7UP
	 p2/HTJaVX+gapTkdlicFm7azvH0XgxyuTDR1kBDMmsOC19Ec8a7l90L5uz9RzDSz1QQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795082077;
	bh=3cagBWWIABFgbwVnKdQmPzWl/TvM7jmgNAN8EpoKaeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MWqpjOdWF4evXIYIcc5GUtmdHxvZsDrSYTAgae1x5RJD1XEbgQgw5oSsdwnwAl9/I
	 WqcHJ5RnZWQNdxwMxH0fpc0TkaxJzhzvDAS+QlRNsPJBUTCrRPt1h/Z0K7mJULwwZS
	 fKSEzyzexkgzVdUQtIbLt1+B/cFaZ9ZAxFiq06eARfbxOihXPQqK9FssK7NOqu761D
	 X/UBwGbkHoLZewqe1nJjVWsd4W3J/FSaB0+Ak3TCAiuUXBGRKGMkgqoCl7rF5h6+pk
	 Z9Um8DZcw/zcye6ZpwKJGDmwm45JcjU2e89x8ZBzEku+XsUqjvsl7BmUVBOd6eZ/ib
	 KNRGEbXCt80Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57761606A8;
	Thu, 19 Nov 2026 09:54:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E29F2A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D34E3810A6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0pv0VeJffMJ for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA8178108A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Nn9OpXz5
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA8178108A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:54:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A35DC46A67;
 Thu, 19 Nov 2026 09:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121D71F000C5;
 Thu, 19 Nov 2026 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795082073;
 bh=3cagBWWIABFgbwVnKdQmPzWl/TvM7jmgNAN8EpoKaeI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Nn9OpXz5FXv0neAdTVULoiDGGF+IKZszVarf5O6t0FK3NGFbLATi74mKfoT0wUJV4
 8uT2HTLFbEcv9gmwzzSw+w9GwctZNWiM8ZZhtck5+mzmAnW97Am5zWlRm886+dguiS
 WTLT+i/JJDk1HuLFkKplRw+EhKwEDypXvFGNL+LhBnN4IqHXZk8doP6bf397tBTLAx
 cO6e/h1vgCfHkp9Z2kXCNlqL8h8/YHcr80Us4KxIOn7M+vh+BunucC36tMPV5lb1il
 2UnW0i2EUfL4SD/6R3ASNSTHaAmEMOSMcObblSKulULdOttPt4QC08hSaPz5zQvH1d
 ziCqMnJiwiTFg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: George Kola <georgekola@google.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Dmitrii Merkurev <dimorinny@google.com>, Simon
 Glass <sjg@chromium.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH] net: fastboot_tcp: enforce rxbuf and stream offset bounds
In-Reply-To: <CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=kMsYi+Pe6mvQ@mail.gmail.com>
References: <CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=kMsYi+Pe6mvQ@mail.gmail.com>
Date: Thu, 19 Nov 2026 10:54:31 +0100
Message-ID: <xhkdbik1tp2nc.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi George,

Thank you for the patch.

On Sun, Nov 15, 2026 at 09:12, George Kola <georgekola@google.com> wrote:

> tcp_stream_rx() copies incoming TCP payload bytes into the static
> 74-byte rxbuf without validating rx_offs or len, enabling a single TCP
> segment larger than rxbuf to overwrite adjacent globals. In addition,
> tcp_stream_on_rcv_nxt_update() treats cumulative rx_bytes as unread
> buffer bytes without subtracting data_read (causing fragmented reads to
> parse stale bytes and multi-command memmove() calls to overflow rxbuf)
> and does not bound cmd_size against FASTBOOT_COMMAND_LEN, while
> tcp_stream_tx() does not clamp copies to maxlen or guard tx_offs <
> tx_last_offs.
>
> Handle overlapping TCP retransmits in tcp_stream_rx() and return -1
> when offset + len exceeds sizeof(rxbuf) so tcp_rx_user_data() aborts
> with TCP_RST. Derive unread =3D rx_bytes - data_read in
> tcp_stream_on_rcv_nxt_update(), reset the stream if unread exceeds
> sizeof(rxbuf), reject cmd_size > FASTBOOT_COMMAND_LEN, ensure txbuf is
> NUL-terminated, and clamp tcp_stream_tx() copies to maxlen.
>
> Fixes: 443d319180a6 ("net: add fastboot TCP support")
> Fixes: bf962de97c37 ("net/tcp: improve tcp framework, use better state ma=
chine")
> Signed-off-by: George Kola <georgekola@google.com>

As for Guillaume, it's corrupted for me as well:

$ b4 shazam -s -l --check CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=3DkMsYi+Pe=
6mvQ@mail.gmail.com
Looking up CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=3DkMsYi+Pe6mvQ@mail.gmail=
.com
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 2 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
Retrieving patchwork CI status, may take a moment...
---
  =E2=9C=93 [PATCH] net: fastboot_tcp: enforce rxbuf and stream offset boun=
ds
    + Reviewed-by: Guillaume La Roque <glaroque@baylibre.com> (=E2=9C=93 DK=
IM/baylibre.com)
    + Link: https://patch.msgid.link/CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=
=3DkMsYi+Pe6mvQ@mail.gmail.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: 183: ERROR: patch seems to be corrupt (line wr=
apped?)
  ---
  =E2=9C=93 Signed: DKIM/google.com
---
Total patches: 1
---
Applying: net: fastboot_tcp: enforce rxbuf and stream offset bounds
Patch failed at 0001 net: fastboot_tcp: enforce rxbuf and stream offset bou=
nds
error: corrupt patch at /home/mkorpers/work/upstream/u-boot/.git/worktrees/=
u-boot-dfu/rebase-apply/patch:10
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"

Consider using the web submission endpoint with b4 if your
email provider mangles patches:
https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-w=
ith-the-web-submission-endpoint

I'll try to review below anyways

> ---
>  net/fastboot_tcp.c | 68 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 54 insertions(+), 14 deletions(-)
>
> diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
> index b9b4f707b1..aa2dcb1443 100644
> --- a/net/fastboot_tcp.c
> +++ b/net/fastboot_tcp.c
> @@ -25,8 +25,19 @@ static void tcp_stream_on_rcv_nxt_update(struct
> tcp_stream *tcp, u32 rx_bytes)
>  	__be64	len_be;
>  	char	saved;
>  	int	fastboot_command_id, len;
> +	u32	unread;
>
> -	if (!data_read && rx_bytes >=3D handshake_length) {
> +	if (rx_bytes <=3D data_read)
> +		return;
> +	unread =3D rx_bytes - data_read;
> +	if (unread > sizeof(rxbuf)) {

nitpick: Can we add a printf() here? To be consistent with the existing
error handling (in case of a bad handshake) below.

Rest looks good, thanks

> +		tcp_stream_reset(tcp);
> +		return;
> +	}
> +
> +	if (!data_read) {
> +		if (unread < handshake_length)
> +			return;
>  		if (memcmp(rxbuf, handshake, handshake_length)) {
>  			printf("fastboot: bad handshake\n");
>  			tcp_stream_close(tcp);
