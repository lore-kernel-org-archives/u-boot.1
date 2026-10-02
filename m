Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C64CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 17:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49DFC60880;
	Fri,  2 Oct 2026 17:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcf_qSYZO2DK; Fri,  2 Oct 2026 17:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4AB126065E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790961027;
	b=iIbCLQoIso1WSSy9kIy2NKL18MT7wbX1/T1WyaYNzlxujIp40xrvK/uqni+4DHTEIsUW
	 I4JDPPFMcZAzYwU/qB0z1+S+H/JGDBd7aEPLGFAhzsQ0+wjkuhA5ag9DHdeZXc3Jldok7
	 TRK/2hYmT8/1Q6SbEsdeVEAGWBVMw+BI7u7lfxvHPuKH8HnavpWy98ot2RpvdfAdbXWYh
	 hyJC63rKOqHHvOJzF1jNh1CqJk4VpX4hH+enMBs3EXPhG3PLoM4uqUIHRLz70NneL+1wv
	 aiKfDmBkLbnDNnPnczzicCBu4xQpfdzSkX8FwKV6Zv23ZBt6byb3nzz6wXDU7IlT8ZA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790961027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PSGLRMsLeQrs5Y4Ko313bLUt+9/1oZsck5GlzpEagx8=;
	b=aaH+THJFAnuOT7+fr/1TAzxQpJtsn13M4YIa8U6fwox39MOdNy2l9feGoFnwtcsB+9+K
	 i+z8Ej9t9J9CoXWCJxjNgW8zojLypK5FasYMcY6v/Khl12lvlViAg/x5IVJJ4eszY++fO
	 xr4vsrx7PGnSxiO1kl1B3y3n2H7kE6HhY0LV6CF21s0xBu4tiogShHHtbL4hhpBXiZ4Ik
	 dTAOYeBrRDeEhxek0kB+9mpkLbJUHThP/x2IP59+rppiVnm8G0nGWUI0eNwfyXdJAlV2k
	 m++BsjwJlQ4BpYGsyK2+VSCtbjPBrsNDJkSPTRm+ot4R+lpcF/8OP6+YWr2XEw0GPPg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790961027;
	bh=PSGLRMsLeQrs5Y4Ko313bLUt+9/1oZsck5GlzpEagx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ab1UCPI/0hpQOC0eboBk3UCyN2oDHItZGJPg9FLWUiZV+h45Vq127DyE4NHotahIs
	 Dv/3WSHJMEsyzjs1y2tr122NoChOaDYHutmw9+17MpYmA8wUGzLtmM8XUHKPhvXWeO
	 u5uFLl9MiGa8j5AAH+ApbydpktnkojnivgS4u9e9q+ybYcUZfGmsF9tg8IUgIZ+DF2
	 mhSrSalVPXb5LLo2StMG+4OYpFCmeHxbJATkUbWAgsrryCz4jSJnAWQS0mMPoQJ6nl
	 j0j0+Smm36daV4P7i0yVIC4zPmA2QDbxWTy84dOH720RxJvflVhc+fh4rKxMzHBYSu
	 ue9iFJ3BWi4fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AB126065E;
	Fri,  2 Oct 2026 17:10:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81159282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E7D5400C7
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qohL1dXZ07y1 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 17:10:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 77B074004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790961024;
 b=ogBqKYlRQpLPYIsHs/INvrs2C2Gg1rU8SgLZlMANmtjz5HCXidPW54wHbK+uAT+EDNMw
 lqY88KYcQoNMIN/DuOjC0go/B6XdYJYNjZXDitYeZTwTe0M78YH1byalMQ1CyOcmXd3VQ
 IIbhIV1wrpZFmFeikUO2eQ3RraSU2YQgDAsq5T27MC6DIMeo34V2L7ORT7ndlLUHVIhgI
 1GJIiMqvX6xw5MSsjWmnbVv3v1gP7ga/D0fPfWm9+ThDwoJ3hqRolseyvCUZ+8B+un5k4
 zVlDt/Wief7p22yc7LEPtkP5u6Z1PetlJteXafZR9CTCD+5jHITXooTzJOw2Cv/pWag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790961024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=PSGLRMsLeQrs5Y4Ko313bLUt+9/1oZsck5GlzpEagx8=;
 b=B5+E/LtA3rcfF3UKsrRJPkQE1iJJNJ48cNhVXVQmIJpD6o+dAP3CMtL+zmszfMuwXW1I
 1gBAlrXUMy48o1/z7w9r9RxnRNDpavHJrishvWgegTWTRHAPMKAbuBrbfkYXkxMiuw10B
 Dyz/utkj/7JUIzygbPEeA3XpVgBOQPVwF+yrycy5K1hJpA5qLQn1itvUNKCbkrAK8p6kA
 gk0sh/eqmjNbGgsr73grCaW0SO8QiP/dw7Z9Xi/cksAzZmifsIo7w3YoJZzE/OfE0om7O
 GWjApJ2BfLHpbUUwRTzlAd1WN1eTzsfUEk3/ba9F24bM0eyIAuuhJQ97Ag/3/7qS++w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=6DTpQciU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=6DTpQciU
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77B074004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:10:23 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae7aa02cb6so3154989a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 10:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790961022; cv=none;
 d=google.com; s=arc-20260327;
 b=qxmDccDrexFIILkEsJs0OSqbenAppMXKXb3+q2bfnDL+lCAyZHl2L+74l51lXaA60E
 puHAcOO+diUVeAqPAzVc7BB81U2oLRq3ZAOfeRAMBzRAjiMh2aBxcFpQZZ5EnKIXW2lT
 U/cyLS5dffb6EiiQAggRBalzePcLg5gFH50eSwx3VQ9ahXFuCsb647JthvWu4L5wHTUG
 bcGUhYBVfVMJ7q3laEwUvrbgnw55FAAvA8WdqMyROSfg/5hrUeSuVzbD9hfai2Y9sA8s
 9cZaeEdr5nTz5BdbabmJMm82S06xUKjhoWYToio8WcIUz6ZDn7TBToLumZagoqu7XewY
 WeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PSGLRMsLeQrs5Y4Ko313bLUt+9/1oZsck5GlzpEagx8=;
 fh=WYeCP68VEjpUB8p713Bz9KPQAHntzgF5i5gw5H5BDD0=;
 b=JortvVuMFT3gZO+mqNh681Zm/2lf5AZ4jr+nLe/DJ9hScsnGObFUm7mKpmHSebf/sD
 4T4+1m0iTnbuuYGcQl+8wJSKPq7O5BKBmXP8F7Q4chc2W4QIhLptgyo73SPS0ugpDnvp
 Xd5sqQQ1KcbyUtn0tdv9FlXzgTUGsTvip++oyHalM66AMgd7V8BB8bQvicjIuj0okYiq
 GIpc00+SfDKpoI/C6kk7VBESczhpSpiRMOPScFiEkvrHctXApIUNSQo/sB4i9n/oHTah
 //mdRaNZrrE7p21wYomG6hhwq9k4kOknQG/6qzVilgPBYisHt08FDJHpSzGwgRiZFUbf
 O9fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790961022; x=1791565822;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PSGLRMsLeQrs5Y4Ko313bLUt+9/1oZsck5GlzpEagx8=;
 b=6DTpQciUuFwM+LHG+rltLTYaGgHRzpR9bvESqKUYnErpWgWpHFwgaNp1Nfpg3bdS1h
 nuP478b6Td5/Qxz7Zau/S6NUx6az7SQxKx/6ulBk/JUD4Ia6IUn1uMiVb8hcSPITBOOV
 4sNkxzYscNkVEg8weEzj+8tIj5JDgLWteIL7+LKy0ve8Uz7XDTnfmkI2lFZCAbup42PQ
 4+/s2e2rpvV41yFbaMs3RvDZBxjDpCrJmI5lGg6oFG5XrMA7QvdtOvh4zjpdvtqfRy2O
 LEyk2p//RzKUndx6UoWYgzkzHjeDrbNs6r4H9kZ+7zC0tNQ+u9En6Q2K1Kt/+4DOulys
 XW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790961022; x=1791565822;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PSGLRMsLeQrs5Y4Ko313bLUt+9/1oZsck5GlzpEagx8=;
 b=k2U0cKBVlGOyGg0VnL0Mv+BeKjc1CgNxAElyG9sNX6GBv+gIl7swNgwsIK59pIgPo4
 a9AnsFPNfhFIxpMwgUwJPzhAVki6eMTwUkaxwoXx6XRhxhKRL2LA0nCUWDzB8DG6IGx2
 NpdPKXET49X5znTC6zeQkAqxWmF7HPrnGuhitsrnV+NaLAewg4WgoBNn/KhNkSTfwCms
 kBc6XX5F8C+StxXXWw3Z5QXAIefERf9F1IhYR5tGBVe4C0lw/H5bQLj9IiYbLOHWalZc
 VfPnzuWWNNpaXvlYS9+eTqxxD21K3CNXVy0ap4LywJ7UVXSDjSuyp+azLx21wXzTDvNn
 zRng==
X-Gm-Message-State: AFq9FYL6qB+D/GqWDgWinuRirBLMr3GcjiDQbjZXJ/Gp3Oo+ibMG6SwY
 lG0kEUT0ULs+3plo+VCtGUDKA0hsQM/5uD5CFLiAPjeFjx6M7RzhYIzmkl0M1lru1Fg9Wsqepqb
 mW47HNjXYDJ9JU5CK5UbCK2W679HX1Qf3PC8QpexKNQ==
X-Gm-Gg: AYBFou0o2FWYWFKY+4NfvnujcDLEv5hnASLwIxxB62RfBV2pXQdtKrATE6dWK64c1rF
 4yv0M8zW4RpbZBJPU2fRRCLtAXDlOtMBOMr3RNL8tYzoOqJVID3CaWLUo8Gaz5s/j8GxQ0BJKmm
 fPSbfHpsT9FCG0m+UKgajYzacNPo6l6JRu3BsuvPtaoLwW/JiKcCCmP7xVbOAGmbznOiWD1ATi+
 cLcq26O21CS1P0LWOvIvc1GrfA7GNE3zA+IasdaBCeeaeGJp/iC/OAOaEN1P1t9Hz91W5bpydEm
 Q0YkHgWaO2it0L49/R4TFWXbNqSTkqjbTw/149L+dBP/7rZWH42oAAgmfpfKshpeen90UtK5jCR
 ap9BrmwdfJzK4
X-Received: by 2002:a17:907:9408:b0:c29:286e:2e3e with SMTP id
 a640c23a62f3a-c2e4af63c8dmr244364666b.38.1790961021663; Fri, 02 Oct 2026
 10:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261001034142.3487023-1-suraj.hanumantkakade@amd.com>
In-Reply-To: <20261001034142.3487023-1-suraj.hanumantkakade@amd.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 2 Oct 2026 21:10:11 +0400
X-Gm-Features: AclHuK8ObuDBlH60ro0yd6GBeu-Uka2qRRrTCMdoMe9FoQs3eJqCXS3yIXop4q4
Message-ID: <CAKTNdwFesjR-02nawPMPRta8_cnTD6vUDPXw9Eu86hnO-Y_=1w@mail.gmail.com>
Subject: Re: [PATCH] boot: pxe_utils: Fix NULL strchr when parsing append
 initrd=
To: Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com, 
 padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, Rob Herring <rob.herring@calxeda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Suraj,

On Thu, Oct 1, 2026 at 7:41=E2=80=AFAM Suraj Kakade
<suraj.hanumantkakade@amd.com> wrote:
>
> parse_label() takes an initrd=3D filename embedded in an append line
> and computes its length as strchr(s, ' ') - s. When initrd=3D is the
> last token, the append line ends at newline, so there is no blank
> after the filename. strchr() returns NULL, the pointer subtraction
> is not a length, and malloc() and strncpy() use an invalid size.
>
> If strchr() finds no space, use strlen(s) as the length.
>
> Fixes: 34bd23e42f3b ("pxe: parse initrd file from append string")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> ---
>  boot/pxe_utils.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 8c1310dabeb..d4c57ff11f9 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -1285,6 +1285,7 @@ static int parse_label_kernel(char **c, struct pxe_=
label *label)
>  static int parse_label(char **c, struct pxe_menu *cfg)
>  {
>         struct token t;
> +       char *end;
>         int len;
>         char *s =3D *c;
>         struct pxe_label *label;
> @@ -1326,7 +1327,8 @@ static int parse_label(char **c, struct pxe_menu *c=
fg)
>                         if (!s)
>                                 break;
>                         s +=3D 7;
> -                       len =3D (int)(strchr(s, ' ') - s);
> +                       end =3D strchr(s, ' ');
> +                       len =3D end ? (int)(end - s) : (int)strlen(s);

Looks like your base tree is behind next. Have you tried 5f80d8614ca2
("pxe_utils: harden the "append" parser against malformed input")?

Best regards,
Alexey
