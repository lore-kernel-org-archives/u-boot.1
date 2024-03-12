Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124E6C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 11:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F5487E3D;
	Tue, 12 Mar 2024 12:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=naver.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=naver.com header.i=@naver.com header.b="GIJmBGEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99D26876F3; Tue, 12 Mar 2024 01:37:42 +0100 (CET)
Received: from cvsmtppost06.nm.naver.com (cvsmtppost06.nm.naver.com
 [114.111.35.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C1B87DB1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 01:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lionkang70@naver.com
X-Originating-IP: 211.234.196.32
X-Works-Smtp-Source: wdYXKxgwFqJCpNmZFxtwWHF0
Received: from cvsendbo004.nm ([10.112.24.36])
 by cvsmtppost06.nm.naver.com with ESMTP id 8U6tNcpuSvqGxl2Ai-TLFA
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:37:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208; 
 t=1710203852; bh=GAKHN5GBXVehi3E+lXrVt5c7H415s0NgNsESNED/Ym4=; 
 h=Message-ID:Date:From:To:Subject:From:Subject:Feedback-ID:
 X-Works-Security;
 b=GIJmBGEHN0VcFBz+ywpLTSPiYJxX+uMNMH/2wDxk5GGbTkNICFfioy8m0d/vJSgmm
 tGRcw7ia3lhAvEiiVRiuL1dwlqk3A6NBDSdZ0h2W6tsEalfYk1jRDXee9xsX3Tn/uT
 x3WZfC9xbp0eJF1exTJ0z4w71I62AhFiyx+vSyojJTqDxdPqmSMbyeTVOjNkZVDyZL
 k2SKg/PtaHgF9KRfExYRMJDyi1veEGiREO0LdBuWy/H4GnHDGHLcC2gzg2v/dXMuqH
 cm0juwVegYUwUCjbEm/Me/6RAC9s4FITSkU1YGb8+Vf7reJaYig17qMCBvfVPzSfGV
 TiAF5CsYDeAMA==
X-Session-ID: OPYqKAtZKAUTaAE-BqUwWz0TW4RCW4bXKVYdFAvZKAK9axKrFxu
MIME-Version: 1.0
Message-ID: <b5b3a55e992db6abc945a8af234b9c20@cweb001.nm.nfra.io>
Date: Tue, 12 Mar 2024 09:37:32 +0900
From: =?utf-8?B?6rCV7ZuI?= <lionkang70@naver.com>
In-Reply-To: <20240311182423.GB1523872@bill-the-cat>
References: <SEYPR01MB5364E20BEC422DCA667399F5A3242@SEYPR01MB5364.apcprd01.prod.exchangelabs.com>
 <20240311182423.GB1523872@bill-the-cat>
Importance: normal
To: =?utf-8?B?VG9tIFJpbmk=?= <trini@konsulko.com>,
 =?utf-8?B?S2FuZyBMaW9u?= <hkang70@hotmail.com>
Cc: =?utf-8?B?dS1ib290QGxpc3RzLmRlbnguZGU=?= <u-boot@lists.denx.de>,
 =?utf-8?B?bGlvbmthbmdAd2F2ZXRjLmNvbQ==?= <lionkang@wavetc.com>
Subject: =?utf-8?B?UmU6IEFib3V0IFUtQm9vdCBMaWNlbnNl?=
X-Originating-IP: 211.234.196.32
X-Works-Send-Opt: EQndjAIYjHmqaAvlKAJYFqUlFBwYKt==
X-Mailman-Approved-At: Tue, 12 Mar 2024 12:12:09 +0100
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

RGVhciBUb20KClRoYW5rIHlvdSBmb3IgeW91ciByZXBseSBzb29uLgpZb3UgbWVhbiBvbmx5IGNo
YW5nZWQgVS1ib290IG5lZWQgdG8gY29tcGx5IHdpdGggdGhlIGxpY2Vuc2U/ClRoZSBwcm9wcmll
dGFyeSBPUyBubyBuZWVkIHRvIGRpc2Nsb3NlKGRvbid0IGNhcmUpIGF0IHRoaXMgdGltZSwgZXZl
biBpZiB0aGV5IGFyZSBtZXJnZWQgYnkgb25lIGltYWdlLiByaWdodD8KCndhaXRpbmcgZm9yIHlv
dXIga2luZGx5IHJlcGx5LgoKUmVnYXJkcwpMaW9uCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQpGcm9tOiAiVG9tIFJpbmkiPHRyaW5pQGtvbnN1bGtvLmNvbT4KVG86ICJLYW5nIExpb24iPGhr
YW5nNzBAaG90bWFpbC5jb20+OwpDYzogInUtYm9vdEBsaXN0cy5kZW54LmRlIjx1LWJvb3RAbGlz
dHMuZGVueC5kZT47ICJIT09OIEtBTkciPGxpb25rYW5nNzBAbmF2ZXIuY29tPjsgImxpb25rYW5n
QHdhdmV0Yy5jb20iPGxpb25rYW5nQHdhdmV0Yy5jb20+OwpTZW50OiAyMDI0LTAzLTEyICjtmZQp
IDAzOjI0OjIzIChHTVQrMDk6MDApClN1YmplY3Q6IFJlOiBBYm91dCBVLUJvb3QgTGljZW5zZQoK
T24gTW9uLCBNYXIgMTEsIDIwMjQgYXQgMDU6NDA6MTlBTSArMDAwMCwgS2FuZyBMaW9uIHdyb3Rl
OgoKPiBEZWFyIERBUwo+Cj4KPiBUaGlzIGlzIGxpb24uIE5pY2UgdG8gbWVldCB5b3UuCj4KPgo+
IEknbSBzZW5kaW5nIHlvdSBhbiBlLW1haWwgYmVjYXVzZSBJIGhhdmUgYSBxdWVzdGlvbiBhYm91
dCB0aGUgVS1Cb290IGxpY2Vuc2UuCj4gSSB3b3VsZCBsaWtlIHRvIGtub3cgYWJvdXQgdGhlIG9i
bGlnYXRpb24gdG8gZGlzY2xvc2UgdGhlIFUtQm9vdCBjb2RlIGN1cnJlbnRseSBwcm92aWRlZCBi
eSBYaWxpbngoenlucU1QKS4KPgo+Cj4gMS4gV2hlbiB3ZSB1c2UgYSBjb21tZXJjaWFsIE9TIGNv
ZGUgY2FsbGVkIFJURU1TLCB3ZSB1c2UgVS1Cb290IGFzIHRoZSBib290bG9hZGVyLgo+IEF0IHRo
aXMgdGltZSwgZXZlbiBpZiBSVEVNUyBPUyBpcyBjb21tZXJjaWFsLCBpZiB3ZSBtZXJnZSBhbiBp
bWFnZSBzdWNoIGFzIGFuIG9wZW4gc291cmNlIGNhbGxlZCBVLUJvb3QgdG8gbWFrZSBhIGZpbmFs
IGltYWdlIGFuZCB1c2UgaXQsIHNob3VsZCBJIHJlbGVhc2UgYWxsIHRoZSBjb2Rlcz8gSSB3YW50
IHRvIGtub3cgdGhlIHNjb3BlIG9mIGRpc2Nsb3N1cmUuCj4KPiBEbyB3ZSBldmVuIGhhdmUgdG8g
ZGlzY2xvc2UgY29tbWVyY2lhbCBSVEVNUyBPUyArIEFwcGxpY2F0aW9uPwo+Cj4KPiAyLiBPciBk
byB5b3Ugc2VlIG9ubHkgVS1Cb290IGFzIGEgc2VwYXJhdGUgaW1hZ2UsIGFuZCBzaW5jZSB0aGUg
T1MgaXMgY29tbWVyY2lhbCwgdGhlcmUgaXMgbm8gbmVlZCB0byBpbnRlcnByZXQgaXQgc2VwYXJh
dGVseSBhbmQgZGlzY2xvc2UgaXQ/Cj4KPiBBdCB0aGlzIHRpbWUsIHNob3VsZCB0aGUgVS1Cb290
IGJlIGRpc2Nsb3NlZCBhY2NvcmRpbmcgdG8gdGhlIGxpY2Vuc2Ugb3Igbm90PyBJIHdvbmRlci4K
Pgo+Cj4gY2YpIFdlIHdpbGwganVzdCBjaGFuZ2Ugc21hbGwgcGFydCBmb3Igb25seSBkZWZpbml0
aW9uLCBidXQgSSdtIGFmcmFpZCB0aGF0IHdlIGhhdmUgdG8gZGlzY2xvc3VyZSBvdXIgZXZlcnkg
Y29kZSBvZiBSVEVNUyBhbmQgQXBwbGljYXRpb24uCj4KPiBUaGF0J3Mgd2h5IEknbSBxdWVzdGlu
ZyBpdCBub3cuCj4KPiBJIGtub3cgeW91J3JlIGJ1c3ksIGJ1dCBwbGVhc2UgYW5zd2VyIG1lLgoK
VGhpcyBpcyBhIHF1ZXN0aW9uIGZvciB5b3VyIGNvbXBhbnkncyBsYXd5ZXJzLiBVLUJvb3QgY2Fu
IG9mIGNvdXJzZSBiZQp1c2VkIHRvIGxhdW5jaCBhIHByb3ByaWV0YXJ5IE9TLiBDaGFuZ2VzIHlv
dSBtYWtlIHRvIFUtQm9vdCBuZWVkIHRvCmNvbXBseSB3aXRoIHRoZSBsaWNlbnNlLgoKLS0KVG9t
Cgo=
