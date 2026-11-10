Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249AA606A332
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xkLVgLre;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQ9eWsw1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9A13810A5;
	Tue, 10 Nov 2026 08:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0o6omf9a6MYg; Tue, 10 Nov 2026 08:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 088F080F36
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794301064;
	b=WGKUFRnkgvZdl/v7O5XOckAlR9P2DqbQWY+4sA/mfPm53vSp1T1yK25HQYncjHUdlyQ/
	 kZx+9mUI2q/qmit28LzWMg/evGQG1ImXNelGqdBg0/dOpTPXiWg0ZGQ+ASUty1+Ow9hRK
	 jIGWsgkNM2Lv8kifSKYyfdEk/dnsSliNWpPAlKvpZdSvgokB++ffDGuEH2XlSY5Tjv+1s
	 Xha97ap1S/B+9onsVjnplFOhcvgswR5aYKslXZQkRsLO5ldoeUdLtL9J4Dr6epYPu2zVv
	 JEMcjWPoDwY2VjNa2+M+6NUpVk5fTDHpuTxgtLzBN1PEiljiGIIwey41osZ9TGYUQEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794301064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hLj+MU8KAb/8vf4LlXHmqyg8kq0nXRKu++czhzmvHT8=;
	b=d0nhBF+ikQafwzgpN99c1Pmlmm1AblYE+g8JfgBF+CJy5LqOKZqmeHaDh2e0LB3l3KTp
	 hE6WPcBZh0pnBV3zzQf44bnLB11XFLdujYwCBUKNPhwg+y1nd5V3yy3b3TuULsUxGwVoY
	 BV39dYEa20cBAc5RofFFavYNrRd7AOfyTFFz3Jq1zlvARjGvWp7WGDdKsHkryZY/SwQMA
	 SrHELNPhqgcJ8sIfIoCJKdAwrFF7hjriLPTuLj4AM9X5WNkYbYbdFgZOBndzVfOciV9Im
	 /fSjYnylupALHfI20fR1T5XrbHkpJpyVAGwVHeaPvZY+bdsIlzqc5umi/Xqg/IAXRYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794301064;
	bh=hLj+MU8KAb/8vf4LlXHmqyg8kq0nXRKu++czhzmvHT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xkLVgLrexlpLp9aHbRTZxVfQn+RXZIFlUCplvK47TzM9/FkTjIDT4V9IRrQbu2dEk
	 hW6SxIQ0lgau4oGVFDRU1FxZzAnqqietDVk1x7RMbUsWtD4bF4Yk/SBtYnG34V1Np3
	 DKP5znvgyk8oC0YX6PrxS15fTaeq0QRVgIN+NuTRsqoed7i/Zx1ISsRWOqh4rRt+6+
	 l3Ne8kjj9jG9GaGwtz6CthJW9S5o5aQ4rtGUT0Rg5Bi/GneRVoLY+UrTWzxNktJD7J
	 sOsmsgFnddY5oGtYJHuXXCXm/z+0DZH+U5OGPveCMP7cCViZ4Pbhord6Tayd1gisrM
	 vXpMBxqm85YnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 088F080F36;
	Tue, 10 Nov 2026 08:57:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D4C4335
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22D1B40612
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 97rkEIUfSSju for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 08:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FF38405E8
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RQ9eWsw1
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FF38405E8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:57:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D204441705;
 Tue, 10 Nov 2026 08:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DFB1F008A5;
 Tue, 10 Nov 2026 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794301059;
 bh=hLj+MU8KAb/8vf4LlXHmqyg8kq0nXRKu++czhzmvHT8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=RQ9eWsw1tiyoXxHTZ+6JK1HQdn7pUfgWmJYlf6BKzRv9CsQywgByr/UGdg6kPsS9F
 TcMBdNGWOMHEyer2ISUh5Vr3INeC8OLhFqbNjkaSCLpegVFugme4ZOgJ9L6b7Nc2Oi
 je+iLuOwDbWLw/eNa/Q60tPll722ji58rM/GLaWNZT9lIL4JWozKlnXNQ/jkcQt5Ap
 CLohcvU+uDYiR3xPaMCgOQ9ke1jPqUhLxmlKwEC2g1OG03/b3d9PKOlsQsNu8VUt8l
 GtHfkxwl5vPN6vPHqxySy0058cNmis3OHrqOQzs7P/7huJBrfW+fvIDKHSybria1iV
 ALu8kww4LJ9iw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Dan Tran <Dan.Tran1@synopsys.com>, Lukasz Majewski <lukma@denx.de>, Tom
 Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tejas Narendra Joglekar
 <Tejas.Joglekar@synopsys.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 0/2] usb: gadget: add SuperSpeed descriptor support
In-Reply-To: <avJpVgg6Jh_6Fuzu@vbox>
References: <cover.1788488867.git.Thinh.Nguyen@synopsys.com>
 <178911875744.102286.17132958660285497598.b4-ty@kernel.org>
 <avJpVgg6Jh_6Fuzu@vbox>
Date: Tue, 10 Nov 2026 09:57:37 +0100
Message-ID: <xhkdbfqx9vzb2.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thinh,

On Tue, Nov 10, 2026 at 00:52, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> Hi Mattijs, Marek,
>
> On Fri, Sep 11, 2026, Mattijs Korpershoek wrote:
>> Hi,
>> 
>> On Fri, 04 Sep 2026 02:29:22 +0000, Thinh Nguyen wrote:
>> > This series adds SuperSpeed descriptor support for the mass_storage and DFU
>> > gadget functions so they can operate correctly at SuperSpeed.
>> > 
>> > 
>> > Dan Tran (2):
>> >   usb: gadget: mass_storage: add SuperSpeed descriptor support
>> >   usb: gadget: dfu: add SuperSpeed descriptor support
>> > 
>> > [...]
>> 
>> Thanks, Applied to https://urldefense.com/v3/__https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu__;!!A4F2R9G_pg!eQmEMvzVBEkabPwypmYnbdrp3msonmGKhxGZywPB79oo8spNCka6P9eGAae6yp-Ce742VIzmiq9zTSF-cAgowAKSmqcU$  (u-boot-dfu-next)
>> 
>> [1/2] usb: gadget: mass_storage: add SuperSpeed descriptor support
>>       https://urldefense.com/v3/__https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/bc6f3f4b3882fec3eb21457ccaed993b40743725__;!!A4F2R9G_pg!eQmEMvzVBEkabPwypmYnbdrp3msonmGKhxGZywPB79oo8spNCka6P9eGAae6yp-Ce742VIzmiq9zTSF-cAgowHhP3EuL$ 
>> [2/2] usb: gadget: dfu: add SuperSpeed descriptor support
>>       https://urldefense.com/v3/__https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6e3f574e576585b0250ac387475d59e581bb5d9f__;!!A4F2R9G_pg!eQmEMvzVBEkabPwypmYnbdrp3msonmGKhxGZywPB79oo8spNCka6P9eGAae6yp-Ce742VIzmiq9zTSF-cAgowHPGt8hj$ 
>> 
>> --
>> Mattijs
>
> Just following up on these patches. They were previously applied to
> u-boot-dfu-next, but I don't see them there anymore or in mainline.

You are right, there are not there.
I'm terribly sorry. I completely missed to send a PR to Tom with this
included and later on I rebased u-boot-dfu-next and dropped these
patches.

>
> Do you know what happened to them, or whether they still need to be
> picked up?

I'll apply them to u-boot-dfu and send a PR for main this week.

Again, I'm really sorry about this. This is the first time that it
happens to me.

Thank you for your understanding.
Regards
Mattijs

>
> Thanks,
> Thinh
